

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"
//#import "CoinRatio.h"
#import "AppInfo.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "MBProgressHUD.h"
#import "httpRequest.h"
#import "SBJsonParser.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderInfo.h"
#import "JSON.h"
#import "AnquUser.h"
#import "UPPayPluginDelegate.h"
#import "UPPayPlugin.h"
#import "PayWebView.h"
#import "AnquInterfaceKit.h"
#import "UserData.h"
#import "IpaynowPluginDelegate.h"

@interface PayCreditCard : UIViewController<UITextFieldDelegate,UPPayPluginDelegate,IpaynowPluginDelegate>

@property(nonatomic, retain)id<AnquCallback> delegate;


@property(nonatomic, strong) UIView *bg;

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anquPayText;

@property(nonatomic, strong)UIButton *custom;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

//payway
@property(nonatomic, strong)UILabel *anquPayWayText;

@property(nonatomic, strong)UILabel *anquPayValue;

//充值金额
@property(nonatomic, strong)UILabel *anquCashValue;

//商品名
@property(nonatomic, strong)UILabel *anquGoodName;

//角色名
@property(nonatomic, strong)UILabel *anquRoleName;

//安趣用户名
@property(nonatomic, strong)UILabel *anqulocalName;

// 自定义金额
//@property(nonatomic, strong)UITextField *anquCashTextField;

//元宝兑换
//@property(nonatomic, strong)UIButton *anquExchangeBt;

//确定
@property(nonatomic, strong)UIButton *anquCommit;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

//anqu提示
@property(nonatomic, strong)UILabel *anquTipLabel;

@property(nonatomic, strong)NSArray *cashArray;

@property(nonatomic, strong)NSString *headTitle;

@property(nonatomic, strong)UIButton *FlastSelectbutton;//是否是最后一次选中

@property(nonatomic, assign)NSString *payway;

@property(nonatomic, assign)NSString *deviceName;

@property(nonatomic, assign)int *paySource;

@property(nonatomic, strong)MBProgressHUD *HUD;

@property(nonatomic, strong)httpRequest *aliPost;

@property(nonatomic, strong)NSString *money;

@property(nonatomic, strong)NSString *aliUrl;

@property(nonatomic, strong)NSString *strPayWay;

@property(nonatomic, strong)NSString *payUrl;

@property(nonatomic, strong)NSString *payDelegateUrl;

@property(nonatomic, assign) BOOL payorietation;


-(void)unin_callback:(NSString*)tn;

+ (NSString*)urlEncodedString:(NSString *)string;
+ (NSString *)getErrormsg:(NSString*)errorcode;


@end
