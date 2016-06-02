//
//  QutoPayTip.h
//  anquFramework
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.


#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"

@interface QutoPayTip :UIView

@property (strong, nonatomic) IBOutlet UIView *anquTipBgView;//设置背景图

@property (strong, nonatomic) IBOutlet UIImageView *anquTipBgImageView;//设置背景图

@property (strong, nonatomic) IBOutlet UIButton *anquTipBt;//按钮

@property (strong, nonatomic) IBOutlet UIButton *close;//关闭

@property (strong, nonatomic) IBOutlet UIImageView *anquSpliterLine;//分割线

@property(strong, nonatomic)UITextView *tipContent;

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, strong)NSString *tipString;

@property(nonatomic, strong)IBOutlet UIButton *back;

@end
