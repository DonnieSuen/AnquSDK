//
//  LoginOut.h
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "httpRequest.h"
#import "AnquUser.h"
#import "AnquCallback.h"
#import "MBProgressHUD.h"
#import "NSDictionary+QueryBuilder.h"
#import "JSON.h"
#import "UserData.h"
#import "AnquKitConfig.h"


@interface LoginOut : UIViewController

@property(nonatomic, retain)id<AnquCallback> delegate;

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anquPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UILabel *anquWelText;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, strong)UILabel *anquTitle;

@property(nonatomic, strong)UILabel *anquUserName;

@property(nonatomic, strong)UILabel *anquPlay;

@property(nonatomic, strong)UIImageView *anquLogo;

@property(nonatomic, strong)UILabel *anquGameId;

@property(nonatomic, strong)UILabel *anquGameVersion;

@property(nonatomic, strong)UIButton *anquLoginOutButton;

@property(nonatomic,strong)MBProgressHUD *HUD;

@end
