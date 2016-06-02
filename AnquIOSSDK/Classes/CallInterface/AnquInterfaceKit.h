//
//  AnquInterfaceKit.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnquCallback.h"
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AnquKitConfig.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "OrderInfo.h"
#import "DDLegacyMacros.h"

@interface AnquInterfaceKit : NSObject

@property(nonatomic,retain)id<AnquCallback> delegate;//设置callback委托

/**
 *  API单例
 *
 *  @return 返回单例
 */
+(AnquInterfaceKit*)sharedInstance;

//+(void)setLogger;
+(void)setDebugLogOn:(BOOL) debug;

+(int)getLoggerLevel;

/**
 *  设置委托
 *
 *  @param argDelegate 委托
 */
-(void)setDelegate:(id<AnquCallback>)argDelegate;

-(void)setPaypluginaway;

/**
 *  CP商渠道号，游戏ID，游戏ID，渠道号从Anqu后台获取
 *
 *  @param AppId       游戏ID
 *  @param argSourceId 渠道ID
 *  @param argGameKey 游戏key
 */
-(void) setApp:(NSString*)AppId GameKey:(NSString*)argappKey ChannelID:(NSString*)argChannelId PartnerID:(NSString*)partnerID PartnerKey:(NSString*)partnerKey;

/**
 *  激活接口
 */
-(void)activate;

+(void)setOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
+(UIInterfaceOrientation)getOrientation;

/**
 *  登录接口
 */
-(void)anquLogin;

-(void)anquLogin:(BOOL)isshowDraggle;

/**
 *  直登接口
 */
-(void)anquDirectLogin;

/**
 *  个人中心
 */
-(void)anquAcountManage;

/**
 *  不定额订单支付-(void)anquPay:(NSString*)type;
 */
-(void)anquPay:(NSString*)money Subject:(NSString*)subject OutOrderId:(NSString*)mOutOrderid Body:(NSString*)body Pext:(NSString*)mPext;

-(void)anquRequestedpay :(NSString*)paychannel hubView:(MBProgressHUD*)hub;


-(void)suspendView:(int)payway;

-(void)setPlayerInfo:(NSString*)serverid serverName:(NSString*)serverName RoleId:(NSString*)roleld RoleName:(NSString*)roleName RoleLevel:(NSString*)roleLevel;

@property(nonatomic,strong)MBProgressHUD *HUD;

/**
 *  支付宝
 *
 *  @param paramURL 支付宝请求url
 */
//- (void)alixPayResult:(NSURL *)paramURL;

/**
 *  定额支付
 *  @param money      充值金额
 */
//-(void)anquQuotaPay:(NSString*)money Type:(NSString*)mType uid:(NSString*)uid ChannelId:(NSString*)channelId Subject:(NSString*)subject Appid:(NSString*)appId OutOrderId:(NSString*)mOutOrderid  Body:(NSString*)body Pext:(NSString*)mPext;

@end
