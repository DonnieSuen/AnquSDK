//
//  AnquCallback.h
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnquUser.h"

@protocol AnquCallback <NSObject>

//初始化回调
-(void)AnquInit:(int)resultCode;

//登录回调
-(void)AnquLoginOn:(int)resultCode;

//提交用户扩展数据
-(void)AnquPlayerSubmit:(int)resultCode;

//注销回调
-(void)AnquLoginOut:(int)resultCode;

//从支付界面离开
-(void)AnquPayResult:(int)resultCode;

//从个人中心离开
-(void)AnquLeavedAcount;



//检测更新回调
-(void)AnquCheckUpdate;

////激活回调
//-(void)AnquActivateOnSuccess;
////激活失败
//-(void)AnquActivateOnFail;
//登录成功回调
//-(void)AnquLoginOnSuccess:(AnquUser*)user;
//提交用户扩展数据成功
//-(void)AnquPlaySubmitOnSuccess;
//-(void)AnquPlaySubmitOnFail;
//-(void)AnquLoginOutSuccess;
//-(void)AnquPayOnSuccess;

//-(void)AnquLeavedPay:(id)sender;

@end
