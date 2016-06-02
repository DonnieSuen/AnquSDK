//
//  PayManual.h
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"
#import "QutoPayTip.h"

@interface PayManual : UIViewController

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anquPayText;

@property(nonatomic, strong)UIButton *custom;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

//bank
@property(nonatomic, strong)UILabel *anquChooseLabel;

@property(nonatomic, strong)UIImageView *anquFrameView;

@property(nonatomic, strong)UIButton *icbc;//工商银行

@property(nonatomic, strong)UIButton *cmbc;//招商银行

@property(nonatomic, strong)UIButton *ccb;//建设银行

@property(nonatomic, strong)UIButton *abc;//农业银行

@property(nonatomic, strong)UIImageView *anquUnderLine;//下划线

@property(nonatomic, strong)UILabel *anquLocation;

@property(nonatomic, strong)UILabel *anquBankName;

@property(nonatomic, strong)UILabel *anquBankAcount;

@property(nonatomic, strong)UILabel *anquCardLabel;//卡号label

@property(nonatomic, strong)UILabel *anquCardNum;//卡号

@property(nonatomic, strong)UILabel *anquCoustomNum;

@property(nonatomic, strong)UILabel *anquQQ;

@property(nonatomic, strong)UILabel *anquWeixin;

@property(nonatomic, strong)UILabel *anquCustomTime;

@property(nonatomic, strong)UIImageView *anquTip;

@property(nonatomic, strong)UIButton *anquTibPayBt;

@property(nonatomic, strong)UIButton *FlastSelectbutton;//是否是最后一次选中

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, assign)int payway;

@end
