//
//  SafeHome.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "AcountCell.h"
#import "BindPhone.h"
#import "AnquCallback.h"
#import "ModifyPwd.h"
#import "AcountWeb.h"
#import "LoginOut.h"
#import "HumanResources.h"

@interface SafeHome : UIViewController<UITableViewDelegate,UITableViewDataSource>

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

@property(nonatomic, strong)UITableView *anquTableView;

@property(nonatomic, strong)NSArray *anquArray;

@property(nonatomic, strong)NSArray *anquImageArray;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@end
