//
//  Register.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

//#import "DropListView.h"
#import <UIKit/UIKit.h>

#import "AnquCallback.h"
#import "QCheckBox.h"
#import "GetImage.h"
#import "HttpUrl.h"
#import "AppInfo.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "GetImage.h"
#import "httpRequest.h"
#import "MBProgressHUD.h"
#import "checkWifi.h"
#import "UserData.h"
#import "JSON.h"
#import "QutoPayTip.h"

@interface Register : UIViewController<UITextFieldDelegate>

@property(nonatomic, retain)id<AnquCallback> delegate;

@property (strong, nonatomic)  UIView *anquLoginBgView;//设置背景图

@property (strong, nonatomic)  UIImageView *anquLoginBgImageView;//设置背景图

@property (strong, nonatomic)  UITextField *anquLoginUser;//用户名输入框

@property (strong, nonatomic)  UITextField *anquLoginPwd;//密码输入框

@property (strong, nonatomic)  UIButton *anquLoginNowBt;//登录按钮

@property (strong, nonatomic)  QCheckBox *anquRemPwd;//记住密码复选框

@property (strong, nonatomic)  UILabel *anquTitle;

@property (strong, nonatomic)  UIButton *close;//关闭

@property (strong, nonatomic)  UIImageView *anquSpliterLine;//分割线

@property (strong, nonatomic)  UIImageView *anquEditFrame;

@property (strong, nonatomic)  UIImageView* inputSpliterLine;

@property (strong, nonatomic)  UIView *userleftview;

@property (strong, nonatomic)  UIImageView *userLogoImage;

@property (strong, nonatomic)  UIView *leftview;

@property (strong, nonatomic)   UIImageView *passwdLogoImage;

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic, assign)int fastreg;

@property(nonatomic, strong)NSString *passport;//用户名

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, strong)UIButton *back;

@end
