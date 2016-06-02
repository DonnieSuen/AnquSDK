//
//  ModifyPwd.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "httpRequest.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "MBProgressHUD.h"
#import "SBJsonParser.h"
#import "OrderInfo.h"
#import "JSON.h"
#import "AnquUser.h"
#import "ActivateInfo.h"
#import "AppInfo.h"
#import "UserData.h"

@interface ModifyPwd :UIViewController<UITextFieldDelegate> //UIView<UITextFieldDelegate>

//@property (strong, nonatomic)UIImageView *anquModifyBgImageView;//设置背景图

@property(nonatomic, strong)UIScrollView *anquModScrollView;

@property(nonatomic, strong)UIButton *modback;

@property (strong, nonatomic)UIButton *close;//关闭

@property (strong, nonatomic)UIImageView *anquSpliterLine;//分割线

@property (strong, nonatomic)UIView *anquModifyBgView;

@property(nonatomic, strong)UILabel *anqupwdO;
@property (strong, nonatomic)UITextField *anquOldPwd;//旧密码输入框

@property(nonatomic, strong)UILabel *anqupwdN;
@property (strong, nonatomic)UITextField *anquNewPwd;//新密码输入框

@property(nonatomic, strong)UILabel *anqupwdRe;
@property (strong, nonatomic)UITextField *anquRepeatPwd;//重复密码输入框

@property(nonatomic, strong)UIButton *anquModifyBt;

@property(nonatomic, strong)MBProgressHUD *HUD;

@property(nonatomic, strong)httpRequest *aliPost;

@property(nonatomic, assign)UIInterfaceOrientation orientation;

//@property (strong, nonatomic) IBOutlet UIImageView *anquSpliterLine;//分割线

@end
