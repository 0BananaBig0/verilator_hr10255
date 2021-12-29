#pragma once

#include <string>
#include <vector>
#include <unordered_map>

/** @brief 错误类型 */
enum class ErrorType{
    UNKNOWN = -1,
    FALSE,
    TRUE
};

/** @brief 端口类型 */
enum class PortType{
    UNKNOWN = -1,
    INPUT,
    OUTPUT,
    WIRE,
    TYPENUM
};

/**
 * @brief 端口实例形参信息
 * @note  1 - indexRange : uint32_t -> start， uint32_t -> end
 *        2 - 若 start >= end ，则 start 即为引脚号
 */
struct PortInstanceFormalMsg
{
    std::string portInstanceName = "";             // 端口实例名称 (实参)
    bool isArray = false;                          // 是否是数组类型
    std::pair<uint32_t, uint32_t> indexRange;      // 引脚范围
    /**
     * @brief 获取索引
     * @note  仅当 isArray == true 时可以调用
     */
    std::vector<int> getIndexs();   
};

/** @brief 端口实例信息
 *  @note  只需要知道端口的形参以及实参即可
 * */
struct PortInstanceMsg
{
    std::string portDefName;                                      // 端口定义名称 (形参)
    std::vector<PortInstanceFormalMsg> portInstanceFormalMsgs;    // 端口实例组 (实参,参考 c++ 初始化列表)
};

/**
 * @brief 模块实例信息
 * @note  需要知道的信息包括以下 ：
 *        1 - 模块自己的名称
 *        2 - 使用的子模块的名称以及其实例名称 (需要知道其顺序)
 *        3 - 需要知道使用到的子模块的引脚及其实例 (由于传入本身就不保证顺序，所以这里不保证)
 */
struct MoudleInstanceMsg
{        
   // std::string -> subMoudleInstanceName, std::string -> subModuleDefName
   using MouldeDefInstanceMap =  std::unordered_map<std::string, std::string>;
   // (std::string -> subMoudleInstanceNames) ， std::vector<PortInstanceMsg> -> 实例引脚表
   using SubMoudlePorts = std::unordered_map<std::string, std::vector<PortInstanceMsg>>;

   std::string moduleDefName;                              // 模块定义名称   (形参)
   uint32_t    level = 0;                                  // 模块的层级 (用于排序加速,目前其实并没用)
   
   std::vector<std::string>  subMoudleInstanceNames;       // 子模块实例名称  (实参)
   MouldeDefInstanceMap      mouldeDefInstanceMap;         // 子模块实例映射表
   SubMoudlePorts            subMoudlePorts;               // 子模块实例的引脚表  
};
