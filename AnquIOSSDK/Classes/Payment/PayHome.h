//
//  PayHome.h
//  anquFramework
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionPayCell.h"
#import "HttpUrl.h"
#import "GetImage.h"
#import "AnquCallback.h"
#import "PSTCollectionView.h"
#import "PayCreditCard.h"
#import "PayOneCard.h"
#import "PayManual.h"
#import "MBProgressHUD.h"
//#import "CoinRatio.h"
#import "AppInfo.h"
#import "ActivateInfo.h"
#import "MyMD5.h"

//,UICollectionViewDataSource, UICollectionViewDelegate
@interface PayHome : UIViewController<PSTCollectionViewDelegate,PSTCollectionViewDataSource>

//delegate
@property(nonatomic, retain)id<AnquCallback> delegate;

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anquPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UILabel *anquWelText;

@property (nonatomic, strong) UIView *anquPayBgView;//设置背景图

@property(nonatomic, strong)UIImageView *anquPaybackground;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

//用户名
@property(nonatomic, strong)UILabel *anquUserName;

@property(nonatomic, strong)UILabel *anquChooseWay;

//支付方式
@property(nonatomic, strong)PSTCollectionView *anquPayWayCollection;

//图片名字
@property(nonatomic, strong)NSArray *imageNameArray;
@property(nonatomic, strong)NSArray *imageNameArrayCh;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, assign) BOOL payorietation;

-(void)anqupay;

@end
