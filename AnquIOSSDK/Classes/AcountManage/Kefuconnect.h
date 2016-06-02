
//
//  Kefuconnect.h
//
//  Created by Jeff on 15-8-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"

@interface Kefuconnect : UIViewController

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anqukefuText;

@property(nonatomic, strong)UIButton *anquclose;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

//bank
@property(nonatomic, strong)UILabel *anquChooseLabel;

@property(nonatomic, strong)UIImageView *anquFrameView;

@property(nonatomic, strong)UIButton *kefuphone;

@property(nonatomic, strong)UIButton *kefuemail;// 

@property(nonatomic, strong)UIImageView *anquUnderLine;//下划线

//@property(nonatomic, strong)UILabel *anquLocation;

@property(nonatomic, strong)UILabel *anqukefuName;

//@property(nonatomic, strong)UILabel *anquQQ;
//
//@property(nonatomic, strong)UILabel *anquWeixin;

@property(nonatomic, strong)UILabel *anquKefuTime;

@property(nonatomic, strong)UIButton *FlastSelectbutton;//是否是最后一次选中

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, assign)int payway;

@end
