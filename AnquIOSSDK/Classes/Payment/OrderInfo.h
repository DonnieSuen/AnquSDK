//
//  OrderInfo.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface OrderInfo : NSObject

+ (OrderInfo *)sharedSingleton;

//区服ID
@property(nonatomic, strong)NSString *serverId;

//区服名称
@property(nonatomic, strong)NSString *serverName;

//玩家角色ID
@property(nonatomic, strong)NSString *roleId;

//玩家角色名
@property(nonatomic, strong)NSString *roleName;

//玩家角色等级
@property(nonatomic,strong)NSString *roleLevel;

//外部CP订单号
@property(nonatomic, strong)NSString *outOrderid;

//内部订单号
@property(nonatomic, strong)NSString *anquOrderid;

//商品描述名
@property(nonatomic,strong)NSString *subject;

//商品描述主题
@property(nonatomic,strong)NSString *body;
//附加订单信息
@property(nonatomic, strong)NSString *pext;

//支付金额
@property(nonatomic, strong)NSString *money;

//支付方式
@property(nonatomic, strong)NSString *type;
//支付方式名称
@property(nonatomic,assign) NSString *payname;

@property(nonatomic,strong)NSString  *orderAnquInnerDescription;

@property(nonatomic,strong)NSString *ordertime;

//备用......
//玩家id
@property(nonatomic,strong)NSString *uid;

//渠道ID
@property(nonatomic,strong)NSString *channelId;

//游戏商CPID
@property(nonatomic,strong)NSString *cpappid;

//银联的交易号
@property(nonatomic, strong)NSString *transNum;

@property(nonatomic,strong)NSString *cardNo;
//
@property(nonatomic,strong)NSString *cardpass;
//
@property(nonatomic,strong)NSString *cardNorMoney;

@property(nonatomic,strong)NSString *alipayDesc;

@property(nonatomic, strong) MBProgressHUD *HUD;

@property(nonatomic, assign) int paystatus;

-(void)initWithType:(NSString*)mServerId serverName:(NSString*)mServerName RoleId:(NSString*)mRoleId RoleName:(NSString*)mRoleName RoleLevel:(NSString *)mRoleLevel OutOrderId:(NSString*)mOutOrderid Subject:(NSString *)subject Body:(NSString *)body Pext:(NSString*)mPext Money:(NSString*)mMoney Type:(NSString*)mType;

-(void) createDescription;
-(void) setPayname:(NSString *)payname;

@end
