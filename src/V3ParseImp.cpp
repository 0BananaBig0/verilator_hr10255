// -*- mode: C++; c-file-style: "cc-mode" -*-
//*************************************************************************
// DESCRIPTION: Verilator: Netlist (top level) functions
//
// Code available from: https://verilator.org
//
//*************************************************************************
//
// Copyright 2003-2020 by Wilson Snyder. This program is free software; you
// can redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
// SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0
//
//*************************************************************************
// Overview of files involved in parsing
//       V3Parse.h              External consumer interface to V3ParseImp
//       V3ParseImp             Internals to parser, common to across flex & bison
//         V3ParseGrammar       Wrapper that includes V3ParseBison
//           V3ParseBison       Bison output
//         V3ParseLex           Wrapper that includes lex output
//           V3Lexer.yy.cpp     Flex output
//*************************************************************************

#include "config_build.h"
#include "verilatedos.h"

#include "V3Error.h"
#include "V3Global.h"
#include "V3Os.h"
#include "V3Ast.h"
#include "V3File.h"
#include "V3ParseImp.h"
#include "V3PreShell.h"
#include "V3LanguageWords.h"

#include "V3ParseBison.h"  // Generated by bison

#include <sstream>

//======================================================================
// Globals

V3ParseImp* V3ParseImp::s_parsep = NULL;

int V3ParseSym::s_anonNum = 0;

extern void yyerror(const char*);
extern void yyerrorf(const char* format, ...);

//######################################################################
// Parser constructor

V3ParseImp::~V3ParseImp() {
    for (std::deque<string*>::iterator it = m_stringps.begin(); it != m_stringps.end(); ++it) {
        VL_DO_DANGLING(delete *it, *it);
    }
    m_stringps.clear();
    for (std::deque<V3Number*>::iterator it = m_numberps.begin(); it != m_numberps.end(); ++it) {
        VL_DO_DANGLING(delete *it, *it);
    }
    m_numberps.clear();
    lexDestroy();
    parserClear();

    if (debug() >= 9) {
        UINFO(0, "~V3ParseImp\n");
        symp()->dump(cout, "-vpi: ");
    }
}

//######################################################################
// Parser utility methods

void V3ParseImp::ppline(const char* textp) {
    // Handle `line directive
    FileLine* prevFl = copyOrSameFileLine();
    int enterExit;
    fileline()->lineDirective(textp, enterExit /*ref*/);
    if (enterExit == 1) {  // Enter
        fileline()->parent(prevFl);
    } else if (enterExit == 2) {  // Exit
        FileLine* upFl = fileline()->parent();
        if (upFl) upFl = upFl->parent();
        if (upFl) fileline()->parent(upFl);
    }
}

void V3ParseImp::timescalePreproc(FileLine* fl, const char* textp) {
    // Parse `timescale of <number><units> / <number><units>
    VTimescale unit;
    VTimescale prec;
    VTimescale::parseSlashed(fl, textp, unit /*ref*/, prec /*ref*/);
    m_timeLastUnit = v3Global.opt.timeComputeUnit(unit);
    v3Global.rootp()->timeprecisionMerge(fileline(), prec);
}
void V3ParseImp::timescaleMod(FileLine* fl, AstNodeModule* modp, bool unitSet, double unitVal,
                              bool precSet, double precVal) {
    VTimescale unit(VTimescale::NONE);
    if (unitSet) {
        bool bad;
        unit = VTimescale(unitVal, bad /*ref*/);
        if (bad) {
            UINFO(1, "Value = " << unitVal << endl);
            fl->v3error("timeunit illegal value");
        }
    }
    VTimescale prec(VTimescale::NONE);
    if (precSet) {
        bool bad;
        prec = VTimescale(precVal, bad /*ref*/);
        if (bad) {
            UINFO(1, "Value = " << precVal << endl);
            fl->v3error("timeprecision illegal value");
        }
    }
    if (!unit.isNone()) {
        if (modp) {
            modp->timeunit(v3Global.opt.timeComputeUnit(unit));
        } else {
            fl->v3error("timeunit/timeprecision not under a module");
        }
    }
    v3Global.rootp()->timeprecisionMerge(fileline(), prec);
}

void V3ParseImp::verilatorCmtLintSave() { m_lintState.push_back(*parsep()->fileline()); }

void V3ParseImp::verilatorCmtLintRestore() {
    if (m_lintState.empty()) {
        yyerrorf("/*verilator lint_restore*/ without matching save.");
        return;
    }
    parsep()->fileline()->warnStateFrom(m_lintState.back());
    m_lintState.pop_back();
}

void V3ParseImp::verilatorCmtLint(const char* textp, bool warnOff) {
    const char* sp = textp;
    while (*sp && !isspace(*sp)) sp++;
    while (*sp && isspace(*sp)) sp++;
    while (*sp && !isspace(*sp)) sp++;
    while (*sp && isspace(*sp)) sp++;
    string msg = sp;
    string::size_type pos;
    if ((pos = msg.find('*')) != string::npos) msg.erase(pos);
    if (!(parsep()->fileline()->warnOff(msg, warnOff))) {
        if (!parsep()->optFuture(msg)) {
            yyerrorf("Unknown verilator lint message code: %s, in %s", msg.c_str(), textp);
        }
    }
}

void V3ParseImp::verilatorCmtBad(const char* textp) {
    string cmtparse = textp;
    if (cmtparse.substr(0, strlen("/*verilator")) == "/*verilator") {
        cmtparse.replace(0, strlen("/*verilator"), "");
    }
    while (isspace(cmtparse[0])) cmtparse.replace(0, 1, "");
    string cmtname;
    for (int i = 0; isalnum(cmtparse[i]); i++) { cmtname += cmtparse[i]; }
    if (!parsep()->optFuture(cmtname)) yyerrorf("Unknown verilator comment: %s", textp);
}

void V3ParseImp::errorPreprocDirective(const char* textp) {
    // Find all `preprocessor spelling candidates
    // Can't make this static as might get more defines later when read cells
    VSpellCheck speller;
    for (V3LanguageWords::const_iterator it = V3LanguageWords::begin();
         it != V3LanguageWords::end(); ++it) {
        string ppDirective = it->first;
        if (ppDirective[0] == '`') speller.pushCandidate(ppDirective);
    }
    V3PreShell::candidateDefines(&speller);
    string suggest = speller.bestCandidateMsg(textp);
    fileline()->v3error("Define or directive not defined: '"
                        << textp << "'\n"
                        << (suggest.empty() ? "" : fileline()->warnMore() + suggest));
}

void V3ParseImp::tag(const char* text) {
    if (m_tagNodep) {
        string tmp = text + strlen("/*verilator tag ");
        string::size_type pos;
        if ((pos = tmp.rfind("*/")) != string::npos) { tmp.erase(pos); }
        m_tagNodep->tag(tmp);
    }
}

double V3ParseImp::parseDouble(const char* textp, size_t length, bool* successp) {
    char* strgp = new char[length + 1];
    char* dp = strgp;
    if (successp) *successp = true;
    for (const char* sp = textp; sp < (textp + length); ++sp) {
        if (*sp != '_') *dp++ = *sp;
    }
    *dp++ = '\0';
    char* endp = strgp;
    double d = strtod(strgp, &endp);
    size_t parsed_len = endp - strgp;
    if (parsed_len != strlen(strgp)) {
        if (successp) {
            *successp = false;
        } else {
            yyerrorf("Syntax error parsing real: %s", strgp);
        }
    }
    VL_DO_DANGLING(delete[] strgp, strgp);
    return d;
}

double V3ParseImp::parseTimenum(const char* textp) {
    size_t length = strlen(textp);
    char* strgp = new char[length + 1];
    char* dp = strgp;
    const char* sp = textp;
    for (; isdigit(*sp) || *sp == '_' || *sp == '.'; ++sp) {
        if (*sp != '_') *dp++ = *sp;
    }
    *dp++ = '\0';
    double d = strtod(strgp, NULL);
    string suffix(sp);

    double divisor = 1;
    if (suffix == "s") {
        divisor = 1;
    } else if (suffix == "ms") {
        divisor = 1e3;
    } else if (suffix == "us") {
        divisor = 1e6;
    } else if (suffix == "ns") {
        divisor = 1e9;
    } else if (suffix == "ps") {
        divisor = 1e12;
    } else if (suffix == "fs") {
        divisor = 1e15;
    } else {
        // verilog.l checks the suffix for us, so this is an assert
        v3fatalSrc("Unknown time suffix " << suffix);
    }

    VL_DO_DANGLING(delete[] strgp, strgp);
    return d / divisor;
}

//######################################################################
// Parser tokenization

size_t V3ParseImp::ppInputToLex(char* buf, size_t max_size) {
    size_t got = 0;
    while (got < max_size  // Haven't got enough
           && !m_ppBuffers.empty()) {  // And something buffered
        string front = m_ppBuffers.front();
        m_ppBuffers.pop_front();
        size_t len = front.length();
        if (len > (max_size - got)) {  // Front string too big
            string remainder = front.substr(max_size - got);
            front = front.substr(0, max_size - got);
            m_ppBuffers.push_front(remainder);  // Put back remainder for next time
            len = (max_size - got);
        }
        memcpy(buf + got, front.c_str(), len);
        got += len;
    }
    if (debug() >= 9) {
        string out = string(buf, got);
        cout << "   inputToLex  got=" << got << " '" << out << "'" << endl;
    }
    // Note returns 0 at EOF
    return got;
}

void V3ParseImp::preprocDumps(std::ostream& os) {
    if (v3Global.opt.dumpDefines()) {
        V3PreShell::dumpDefines(os);
    } else {
        bool noblanks = v3Global.opt.preprocOnly() && v3Global.opt.preprocNoLine();
        for (std::deque<string>::iterator it = m_ppBuffers.begin(); it != m_ppBuffers.end();
             ++it) {
            if (noblanks) {
                bool blank = true;
                for (string::iterator its = it->begin(); its != it->end(); ++its) {
                    if (!isspace(*its) && *its != '\n') {
                        blank = false;
                        break;
                    }
                }
                if (blank) continue;
            }
            os << *it;
        }
    }
}

void V3ParseImp::parseFile(FileLine* fileline, const string& modfilename, bool inLibrary,
                           const string& errmsg) {  // "" for no error, make fake node
    string modname = V3Os::filenameNonExt(modfilename);

    UINFO(2, __FUNCTION__ << ": " << modname << (inLibrary ? " [LIB]" : "") << endl);
    m_fileline = new FileLine(fileline);
    m_fileline->newContent();
    m_inLibrary = inLibrary;

    // Preprocess into m_ppBuffer
    bool ok = V3PreShell::preproc(fileline, modfilename, m_filterp, this, errmsg);
    if (!ok) {
        if (errmsg != "") return;  // Threw error already
        // Create fake node for later error reporting
        AstNodeModule* nodep = new AstNotFoundModule(fileline, modname);
        v3Global.rootp()->addModulep(nodep);
        return;
    }

    if (v3Global.opt.preprocOnly() || v3Global.opt.keepTempFiles()) {
        // Create output file with all the preprocessor output we buffered up
        string vppfilename
            = v3Global.opt.makeDir() + "/" + v3Global.opt.prefix() + "_" + modname + ".vpp";
        std::ofstream* ofp = NULL;
        std::ostream* osp;
        if (v3Global.opt.preprocOnly()) {
            osp = &cout;
        } else {
            osp = ofp = V3File::new_ofstream(vppfilename);
        }
        if (osp->fail()) {
            fileline->v3error("Cannot write preprocessor output: " + vppfilename);
            return;
        } else {
            preprocDumps(*osp);
            if (ofp) {
                ofp->close();
                VL_DO_DANGLING(delete ofp, ofp);
            }
        }
    }

    // Parse it
    if (!v3Global.opt.preprocOnly()) {
        lexFile(modfilename);
    } else {
        m_ppBuffers.clear();
    }
}

void V3ParseImp::lexFile(const string& modname) {
    // Prepare for lexing
    UINFO(3, "Lexing " << modname << endl);
    s_parsep = this;
    fileline()->warnResetDefault();  // Reenable warnings on each file
    lexDestroy();  // Restart from clean slate.
    lexNew();

    // Lex it
    if (bisonParse()) v3fatal("Cannot continue\n");
}

void V3ParseImp::lexToken() {
    // called from lexToBison, has a "this"
    // Fetch next token from prefetch or real lexer
    int token;
    if (m_ahead) {
        // We prefetched an extra token, give it back
        m_ahead = false;
        token = m_aheadVal.token;
        yylval = m_aheadVal;
    } else {
        // Parse new token
        token = yylexReadTok();
        // yylval // Set by yylexReadTok()
    }
    // If a paren, read another
    if (token == '('  //
        || token == yCONST__LEX  //
        || token == yGLOBAL__LEX  //
        || token == yLOCAL__LEX  //
        || token == yNEW__LEX  //
        || token == yVIRTUAL__LEX  //
        || token == yWITH__LEX  //
        // Never put yID_* here; below symbol table resolution would break
    ) {
        if (debugFlex() >= 6) {
            cout << "   lexToken: reading ahead to find possible strength" << endl;
        }
        V3ParseBisonYYSType curValue = yylval;  // Remember value, as about to read ahead
        int nexttok = yylexReadTok();
        m_ahead = true;
        m_aheadVal = yylval;
        m_aheadVal.token = nexttok;
        yylval = curValue;
        // Now potentially munge the current token
        if (token == '('
            && (nexttok == ygenSTRENGTH || nexttok == ySUPPLY0 || nexttok == ySUPPLY1)) {
            token = yP_PAR__STRENGTH;
        } else if (token == yCONST__LEX) {
            if (nexttok == yREF) {
                token = yCONST__REF;
            } else {
                token = yCONST__ETC;
            }
        } else if (token == yGLOBAL__LEX) {
            if (nexttok == yCLOCKING) {
                token = yGLOBAL__CLOCKING;
            } else if (v3Global.opt.pedantic()) {
                token = yGLOBAL__ETC;
            }
            // Avoid 2009 "global" conflicting with old code when we can
            else {
                token = yaID__LEX;
                yylval.strp = V3ParseImp::parsep()->newString("global");
            }
        } else if (token == yLOCAL__LEX) {
            if (nexttok == yP_COLONCOLON) {
                token = yLOCAL__COLONCOLON;
            } else {
                token = yLOCAL__ETC;
            }
        } else if (token == yNEW__LEX) {
            if (nexttok == '(') {
                token = yNEW__PAREN;
            } else {
                token = yNEW__ETC;
            }
        } else if (token == yVIRTUAL__LEX) {
            if (nexttok == yCLASS) {
                token = yVIRTUAL__CLASS;
            } else if (nexttok == yINTERFACE) {
                token = yVIRTUAL__INTERFACE;
            } else if (nexttok == yaID__ETC  //
                       || nexttok == yaID__LEX) {
                // || nexttok == yaID__aINTERFACE  // but we may not know interfaces yet.
                token = yVIRTUAL__anyID;
            } else {
                token = yVIRTUAL__ETC;
            }
        } else if (token == yWITH__LEX) {
            if (nexttok == '(') {
                token = yWITH__PAREN;
            } else if (nexttok == '[') {
                token = yWITH__BRA;
            } else if (nexttok == '{') {
                token = yWITH__CUR;
            } else {
                token = yWITH__ETC;
            }
        }
        // If add to above "else if", also add to "if (token" further above
    }
    // If an id, change the type based on symbol table
    // Note above sometimes converts yGLOBAL to a yaID__LEX
    if (token == yaID__LEX) {
        VSymEnt* foundp;
        if (VSymEnt* look_underp = V3ParseImp::parsep()->symp()->nextId()) {
            UINFO(7, "   lexToken: next id lookup forced under " << look_underp << endl);
            foundp = look_underp->findIdFallback(*(yylval.strp));
            // "consume" it.  Must set again if want another token under temp scope
            V3ParseImp::parsep()->symp()->nextId(NULL);
        } else {
            UINFO(7, "   lexToken: find upward " << V3ParseImp::parsep()->symp()->symCurrentp()
                                                 << " for '" << *(yylval.strp) << "'" << endl);
            // if (debug()>=9) V3ParseImp::parsep()->symp()->symCurrentp()->dump(cout," -findtree:
            // ", true);
            foundp = V3ParseImp::parsep()->symp()->symCurrentp()->findIdFallback(*(yylval.strp));
        }
        if (foundp) {
            AstNode* scp = foundp->nodep();
            yylval.scp = scp;
            UINFO(7, "   lexToken: Found " << scp << endl);
            if (VN_IS(scp, Typedef)) {
                token = yaID__aTYPE;
            } else if (VN_IS(scp, TypedefFwd)) {
                token = yaID__aTYPE;
            } else if (VN_IS(scp, Class)) {
                token = yaID__aTYPE;
            }
            // Packages (and class static references) we could
            // alternatively determine by looking for an yaID__LEX followed
            // by yP_COLONCOLON (but we can't lookahead after an yaID__LEX
            // as described above.)
            else if (VN_IS(scp, Package)) {
                token = yaID__aPACKAGE;
            } else {
                token = yaID__ETC;
            }
        } else {  // Not found
            yylval.scp = NULL;
            token = yaID__ETC;
        }
    }
    yylval.token = token;
    // effectively returns yylval
}

int V3ParseImp::lexToBison() {
    // Called as global since bison doesn't have our pointer
    lexToken();  // sets yylval
    m_prevBisonVal = m_curBisonVal;
    m_curBisonVal = yylval;

    // yylval.scp = NULL;   // Symbol table not yet needed - no packages
    if (debugFlex() >= 6 || debugBison() >= 6) {  // --debugi-flex and --debugi-bison
        cout << "   {" << yylval.fl->filenameLetters() << yylval.fl->asciiLineCol()
             << "} lexToBison  TOKEN=" << yylval.token << " " << tokenName(yylval.token);
        if (yylval.token == yaID__ETC  //
            || yylval.token == yaID__LEX  //
            || yylval.token == yaID__aTYPE) {
            cout << "   strp='" << *(yylval.strp) << "'";
        }
        cout << endl;
    }
    return yylval.token;
}

//======================================================================
// V3Parse functions

V3Parse::V3Parse(AstNetlist* rootp, VInFilter* filterp, V3ParseSym* symp) {
    m_impp = new V3ParseImp(rootp, filterp, symp);
}
V3Parse::~V3Parse() {  //
    VL_DO_CLEAR(delete m_impp, m_impp = NULL);
}
void V3Parse::parseFile(FileLine* fileline, const string& modname, bool inLibrary,
                        const string& errmsg) {
    m_impp->parseFile(fileline, modname, inLibrary, errmsg);
}
void V3Parse::ppPushText(V3ParseImp* impp, const string& text) {
    if (text != "") impp->ppPushText(text);
}
