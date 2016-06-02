//
//
//  Created by  Jeff on 3/25/15.
//  Copyright (c) 2015 Jeff. All rights reserved.
//



#pragma mark - Public -
typedef struct MsgGameServerResponse
{
    uint32_t len;
    uint32_t command;
    uint32_t status;                //0为成功，其他为失败
}MSG_GAME_SERVER_RESPONSE;


typedef struct MsgGameServer{
    uint32_t		len;                //21
    uint32_t		commmand;           //[0xAA000021]
    char            token_key[16];
}MSG_GAME_SERVER;

typedef struct MsgGameServer_Str{
    uint32_t		len_str;                //41
    uint32_t		commmand_str;           //[0xAA000022]
    char            token_key_str[33];
}MSG_GAME_SERVER_STR;

/**
 *  SDK发送给游戏客户端通知
 */


/**
 * @brief 登陆返回码。
 */
typedef enum{
    /**
     * 登录成功
     */
	AnquLoginOnSuccess	= 0,
    /**
     *登陆失败
     */
    AnquLoginOnFail = 1,
    
    /**
     * 未登陆
     */
    AnquNoLoginOn = 3,
    
}AnquLoginCode;

/**
 * @brief 初始化返回码。
 */
typedef enum{
    /**
     * 初始化成功
     */
    AnquInitSuccess	= 0,
    /**
     * 初始化失败
     */
    AnquInitFail = 1,
    
    /**
     * 未初始化
     */
    AnquNoInit = 3,
    
}AnquInitCode;


/**
 * @brief 提交扩展数据返回码。
 */
typedef enum{
    /**
     * 提交扩展数据成功
     */
    AnquExtSubSuccess	= 0,
    /**
     * 提交扩展数据失败
     */
    AnquExtSubFail = 1,
    
    /**
     * 未提交扩展数据
     */
    AnquNoExtSubmit = 3,
    
}AnquExtInfoCode;


/**
 * @brief 退出登录返回码。
 */
typedef enum{
    /**
     * 退出成功
     */
    AnquLogoutSuccess	= 0,
    /**
     * 退出失败
     */
    AnquLogoutFail = 1,
    
}AnquLogoutCode;

/**
 * @brief 错误范围，用来标识错误是接口返回的还是SDK返回的。
 */
typedef enum{
    /**
     * 购买成功
     */
	AnquPayResultCodeSucceed	= 0,
    /**
     * 禁止访问
     */
    AnquPayResultCodeForbidden = 1,
    /**
     * 该用户不存在
     */
    AnquPayResultCodeUserNotExist = 2,
    /**
     * 必选参数丢失
     */
    AnquPayResultCodeParamLost = 3,
    /**
     * anqu币余额不足
     */
    AnquPayResultCodeNotSufficientFunds = 4,
    /**
     * 该游戏数据不存在
     */
    AnquPayResultCodeGameDataNotExist = 5,
    /**
     * 开发者数据不存在
     */
    AnquPayResultCodeDeveloperNotExist = 6,
    /**
     * 该区数据不存在
     */
    AnquPayResultCodeZoneNotExist = 7,
    /**
     * 系统错误
     */
    AnquPayResultCodeSystemError = 8,
    /**
     * 购买失败
     */
    AnquPayResultCodeFail = 9,
    /**
     * 与开发商服务器通信失败，如果长时间未收到商品请联系客服
     */
    AnquPayResultCodeCommunicationFail = 10,
    /**
     * 开发商服务器未成功处理该订单，如果长时间未收到商品请联系客服
     */
    AnquPayResultCodeUntreatedBillNo = 11,
    
    /**
     * 用户中途取消
     */
    AnquPayResultCodeCancel = 12,
    
    /**
     * 非法访问，可能用户已经下线
     */
    AnquPayResultCodeUserOffLine = 88,
}AnquPayResultCode;



//银联结束购买通知

#define ANQU_CUPPAY_RESULT_NOTIFICATION  @"ANQUUPPayResultNotification"


