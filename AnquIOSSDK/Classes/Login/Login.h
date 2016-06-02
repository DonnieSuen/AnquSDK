//
//  Login.h
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
#import "HttpUrl.h"
#import "DropListView.h"
#import "GetImage.h"
#import "Register.h"
#import "AppInfo.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "GetImage.h"
#import "httpRequest.h"
#import "MBProgressHUD.h"
#import "UserData.h"
#import "JSON.h"
#import "RCDraggableButton.h"
#import "HomeButton.h"
#import "AnquInterfaceKit.h"
#import "AcountWeb.h"
#import "AnquCallback.h"
#import "AcountHome.h"
#import "AnquKitConfig.h"

@interface Login : UIViewController<QCheckBoxDelegate,UITextFieldDelegate,qqLoginPositionDelegate>

@property(nonatomic, retain)id<AnquCallback> delegate;

@property (strong, nonatomic)  UIView *anquLoginBgView;//设置背景图

@property (strong, nonatomic)  UIImageView *anquLoginBgImageView;//设置背景图

@property (strong, nonatomic)  DropListView *anquLoginUser;//用户名输入框

@property (strong, nonatomic)  UITextField *anquLoginPwd;//密码输入框

@property (strong, nonatomic)  UIButton *anquRegisterBt;//注册按钮

@property (strong, nonatomic)  UIButton *anquLoginBt;//登录按钮

@property (strong, nonatomic)  QCheckBox *anquRemPwd;//记住密码复选框

@property (strong, nonatomic)  UILabel *anquForgetPwd;//忘记密码

@property (strong, nonatomic)  UIButton *close;//关闭

@property (strong, nonatomic)  UIImageView *anquSpliterLine;//分割线

@property (strong, nonatomic)  UILabel *anquTitle;

@property (strong, nonatomic)  UIImageView *anquEditFrame;

@property (strong, nonatomic)  UIImageView* inputSpliterLine;

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, strong)NSString *passport;//用户名

@property(nonatomic, retain)NSMutableArray *UserArray;

@property(nonatomic, retain)NSMutableArray *PasswordArray;

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic, strong)UIImageView *tabBarView;

@property(nonatomic, strong)UIView *fullbgView;

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)UIWindow* floatWindow;

@property(nonatomic, assign) BOOL isshowDraggle; //控制tabbar的显示与隐藏标志

- (void)loadAvatarInKeyWindow;

@end
