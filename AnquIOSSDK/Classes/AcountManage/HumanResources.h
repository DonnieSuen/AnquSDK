//
//  HumanResources.h

//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnquCallback.h"
#import "QCheckBox.h"
#import "GetImage.h"
#import "HttpUrl.h"
#import "AppInfo.h"
#import "AnquUser.h"
#import "MyMD5.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "NSDictionary+QueryBuilder.h"
#import "AnquInterfaceKit.h"
#import "ActivateInfo.h"
#import "httpRequest.h"
#import "OrderInfo.h"


@interface HumanResources : UIViewController<UITextFieldDelegate, QCheckBoxDelegate>

@property(nonatomic, strong)UIScrollView *anquScrollView;

@property(nonatomic, retain)id<AnquCallback> delegate;

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anquPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UILabel *anquWelText;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

@property(nonatomic, strong)UILabel *anquTitle;

@property(nonatomic, strong)UILabel *anquUserName;

@property(nonatomic, strong)UILabel *anquWel;

@property(nonatomic, strong)UILabel *anquSex;

@property(strong, nonatomic)QCheckBox *anquMan;//男

@property(strong, nonatomic)QCheckBox *anquWoMan;//女

@property(strong, nonatomic)QCheckBox *anquSecret;//保密

//用户名
@property(nonatomic, strong)UILabel *anquName;

//用户名输入框
@property(nonatomic, strong)UITextField *anquNameEt;

//身份证号
@property(nonatomic, strong)UILabel *anquIdentNum;

//身份证输入框
@property(nonatomic, strong)UITextField *anquIdentNumEt;

//QQ
@property(nonatomic, strong)UILabel *anquQQ;

//QQ输入框
@property(nonatomic, strong)UITextField *anquQQEt;

//资料编辑
@property(nonatomic, strong)UIButton *anquEdit;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic, strong)NSString *sexType;

@property(nonatomic, strong)QCheckBox *lastCheckBox;


@end
