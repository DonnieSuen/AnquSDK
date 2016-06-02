//
//  OrderInfo.m
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "OrderInfo.h"
#import "HttpUrl.h"


@implementation OrderInfo

+ (OrderInfo *)sharedSingleton{
    static OrderInfo *sharedSingleton = nil;
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[OrderInfo alloc] init];
            return sharedSingleton;
        }
    }
    return sharedSingleton;
}

//自定义ActivateInfo
-(void)initWithType:(NSString*)mServerId serverName:(NSString*)mServerName RoleId:(NSString*)mRoleId RoleName:(NSString*)mRoleName RoleLevel:(NSString *)mRoleLevel OutOrderId:(NSString*)mOutOrderid Subject:(NSString *)subject Body:(NSString *)body Pext:(NSString*)mPext Money:(NSString*)mMoney Type:(NSString*)mType
{
    _serverId = mServerId;
    _serverName = mServerName;
    _roleId = mRoleId;
    _roleName = mRoleName;
    _roleLevel = mRoleLevel;
    _outOrderid = mOutOrderid;
    _pext = mPext;
    _money = mMoney;
    _type = mType;
    _subject = subject;
    _body = body;
}

-(void)createDescription
{
    NSMutableString * discription = [NSMutableString string];
    if([self.type isEqualToString:ALIPAYID]){
        
        [discription appendFormat:@"partner=\"%@\"", ALIPARTNER];
        
        [discription appendFormat:@"&seller_id=\"%@\"", ALISELLER];
        
        if (self.outOrderid) {
            [discription appendFormat:@"&out_trade_no=\"%@\"", self.outOrderid];
        }
        
        if(self.subject){
            [discription appendFormat:@"&subject=\"%@\"", self.subject];
        }else{
            [discription appendFormat:@"&subject=\"%@\"", @"游戏付费"];
        }
        
        if(self.body){
            [discription appendFormat:@"&body=\"%@\"", self.body];
        }else{
            [discription appendFormat:@"&body=\"%@\"", @"IOS端购买游戏付费产品"];
        }
        if (self.money) {
            [discription appendFormat:@"&total_fee=\"%@\"", self.money];
        }
        
        [discription appendFormat:@"&notify_url=\"%@\"", ALINOTIFYURL];
        
        [discription appendFormat:@"&service=\"%@\"",@"mobile.securitypay.pay"];
        
        [discription appendFormat:@"&payment_type=\"%@\"",@"1"];//1
        
        [discription appendFormat:@"&_input_charset=\"%@\"",@"UTF-8"];//utf-8
        
        [discription appendFormat:@"&it_b_pay=\"%@\"",ALITIMEOUT];//30m
        
        //        if (self.appID) {
        //            [discription appendFormat:@"&app_id=\"%@\"",self.appID];
        //        }
        //        for (NSString * key in [self.extraParams allKeys]) {
        //            [discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
        //        }
        
        }
    
    _orderAnquInnerDescription = discription;

}

-(void) setPayname:(NSString *)payname{
    _payname = payname;
}

@end
