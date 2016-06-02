//
//  ForgetPass.h
//  AnquIOSSDK
//
//  Created by jiangfeng on 15/4/14.
//  Copyright (c) 2015年 anqu. All rights reserved.
//

#ifndef AnquIOSSDK_ForgetPass_h
#define AnquIOSSDK_ForgetPass_h


#endif

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "AcountCell.h"
#import "AnquCallback.h"
#import "AcountWeb.h"
#import "HumanResources.h"
#import "ResetPwd.h"

@interface ForgetPass : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)id<AnquCallback> delegate;

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anquPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UILabel *anquWelText;

@property(nonatomic, strong)UIWebView *webForView;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

@property(nonatomic, strong)UILabel *anquTitle;

//@property(nonatomic, strong)UILabel *anquUserName;

//@property(nonatomic, strong)UILabel *anquWel;

@property(nonatomic, strong)UITableView *anquTableView;

@property(nonatomic, strong)NSArray *anquArray;

@property(nonatomic, strong)NSArray *anquImageArray;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@end
