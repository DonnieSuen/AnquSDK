//
//  ResetPwd.h
//  AnquIOSSDK
//
//  Created by jiangfeng on 15/4/14.
//  Copyright (c) 2015年 anqu. All rights reserved.
//

#ifndef AnquIOSSDK_ResetPwd_h
#define AnquIOSSDK_ResetPwd_h


#endif

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "AnquCallback.h"
#import "MBProgressHUD.h"
#import "httpRequest.h"
#import "AppInfo.h"
#import "AnquUser.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "JSON.h"
#import "NSDictionary+QueryBuilder.h"
#import "BindPhone.h"

@interface ResetPwd :UIViewController<UITextFieldDelegate> //UIViewController<UITextFieldDelegate>

@property(nonatomic, retain)id<AnquCallback> delegate;

@property(nonatomic, strong)UIScrollView *anquResetScrollView;

@property (strong, nonatomic)UIImageView *anquBindBgImageView;//设置背景图

@property(nonatomic, strong)UIButton *retback;

@property (strong, nonatomic)UIButton *close;//关闭

@property (strong, nonatomic)UIImageView *anquSpliterLine;//分割线

@property (strong, nonatomic)UIView *anquBindBgView;

@property(nonatomic, strong)UILabel *anquTip;

@property(nonatomic, strong)UILabel *anquBindTip;

@property(nonatomic, strong)UILabel *anquphone;

@property(nonatomic, strong)UITextField *anquPhoneEdit;//手机号

@property(nonatomic, strong)UILabel *anquIdent;

@property(nonatomic, strong)UILabel *anquPwd;

@property(nonatomic, strong)UITextField *anquIdentEdit;//验证码

@property(nonatomic, strong)UITextField *anquPwdEdit;//密码

@property(nonatomic, strong)UIButton *anquGetIdent;//获取验证码

@property(nonatomic, strong)UIButton *anquCommit;//提交

@property(nonatomic, strong)NSTimer *countDownTimer;

@property(nonatomic, strong)MBProgressHUD *HUD;

@property(nonatomic, strong)httpRequest *resetPost;

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, assign)BOOL *isbinded;


@end
