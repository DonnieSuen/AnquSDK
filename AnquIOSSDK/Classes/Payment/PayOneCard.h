//
//  PayOneCard.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AlipaySDK/AlipaySDK.h>
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
#import "OrderInfo.h"
#import "JSON.h"
#import "AnquUser.h"
#import "UPPayPluginDelegate.h"
#import "UPPayPlugin.h"
#import "PayWebView.h"
#import "QutoPayTip.h"
#import "IPAddress.h"
#import "httpGBRequest.h"
#import "UserData.h"

@interface PayOneCard : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>


@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anquPayOneCardText;

@property(nonatomic, strong)UIButton *custom;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

//payway
@property(nonatomic, strong)UILabel *anquPayWayText;

@property(nonatomic, strong)UILabel *anquPayValue;

//请选择充值金额
@property(nonatomic, strong)UILabel *anquCashValue;

//元宝兑换
//@property(nonatomic, strong)UIButton *anquExchangeBt;

@property (strong, nonatomic) UIImageView *paycardBgImageView;//设置背景图

//确定充值
@property(nonatomic, strong)UIButton *anquCommit;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

//anqu提示
@property(nonatomic, strong)UILabel *anquTipLabel;

@property(nonatomic, strong)NSArray *cashArray;

@property(nonatomic, strong)UIImageView *anquEditFrame;

@property(nonatomic, strong)UIImageView *inputSpliterLine;

// 卡号
@property(nonatomic, strong)UITextField *anquCardNum;

// 密码
@property(nonatomic, strong)UITextField *anquCardPwd;

@property(nonatomic, strong)UIScrollView *anquScrollView;

@property(nonatomic, strong)NSString *payway;

@property(nonatomic, strong)NSString *headTitle;

@property(nonatomic, assign)int paySource;

@property(nonatomic, strong)UIButton *FlastSelectbutton;//是否是最后一次选中

@property(nonatomic, strong)MBProgressHUD *HUD;

@property(nonatomic, strong)httpRequest *aliPost;

@property(nonatomic, strong)NSString *cardmoney;

@property(nonatomic, strong)NSString *aliUrl;

//支付方式的文字描述
@property(nonatomic, strong)NSString *strPayWay;

@property(nonatomic, strong)NSString *payUrl;

@property(nonatomic, strong)NSString *payDelegateUrl;

@property(nonatomic, strong)UIImageView *anquTip;

@property(nonatomic, strong)UIButton *anquTibPayBt;

+(void) paywithSZF:(MBProgressHUD *)hub;
+(void) paywithJWK:(MBProgressHUD *)hub;


@end
