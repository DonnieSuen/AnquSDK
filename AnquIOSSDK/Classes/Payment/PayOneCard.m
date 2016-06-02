//
//  PayOneCard.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "PayOneCard.h"
#import "AnquInterfaceKit.h"
#import <CommonCrypto/CommonCryptor.h>

@interface PayOneCard ()

@end

@implementation PayOneCard

int ddLogLevel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        ddLogLevel =[AnquInterfaceKit getLoggerLevel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   // _orientation = [UIApplication sharedApplication].statusBarOrientation;
    _orientation = [AnquInterfaceKit getOrientation];
    
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
    
    if (_paySource == 6) {
        _cashArray = [NSArray arrayWithObjects: @"5元", @"6元",@"10元", @"15元",@"20元", @"30元", @"50元", @"100元", @"200元", @"300元", @"500元",@"1000元",nil];

    }else{
        _cashArray = [NSArray arrayWithObjects:@"10元", @"20元", @"30元", @"50元", @"100元", @"150元", @"200元", @"300元", @"500元", nil];
    }
    
    if (_orientation == UIInterfaceOrientationUnknown) {
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0,min, min)];
        bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bg];
        [self initPayValuePortrait];
    }
    else if (UIInterfaceOrientationIsLandscape(_orientation) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0,max, min)];
        bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bg];
        [self initPayValueLand];
        
    }else{
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bg];
        [self initPayValuePortrait];
        
    }
    
    // Do any additional setup after loading the view.
}

-(void)initPayValuePortrait
{
    _paycardBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH,SCREENHEIGHT)];
    [_paycardBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
   // [_paycardBgImageView setImage:[GetImage getRectImage:@"anqu_login_bg"]];
    [_paycardBgImageView setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:_paycardBgImageView];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(cardPayBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayOneCardText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 30)];
    
    if(_paySource == 3){
        _anquPayOneCardText.text = @"移动充值卡";
    }else if(_paySource == 4){
        _anquPayOneCardText.text = @"联通充值卡";
    }else if(_paySource == 5){
        _anquPayOneCardText.text = @"电信充值卡";
    }else if(_paySource == 6){
        _anquPayOneCardText.text = @"骏网充值卡";
    }
    
    _anquPayOneCardText.font = [UIFont systemFontOfSize:15.0];
    _anquPayOneCardText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_anquPayOneCardText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 30)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(cardPayBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    _anquScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, SCREENWIDTH, SCREENHEIGHT - 60)];
    _anquScrollView.pagingEnabled = YES;
    _anquScrollView.delegate = self;
    _anquScrollView.showsVerticalScrollIndicator = NO;
    _anquScrollView.showsHorizontalScrollIndicator = NO;
    
    if (_orientation != UIDeviceOrientationPortrait)
    {//横竖屏button布局
        CGSize newSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 100);
        [_anquScrollView setContentSize:newSize];
    }
    else
    {
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50);
        [_anquScrollView setContentSize:newSize];
    }
    
    [self.view addSubview:_anquScrollView];
    
    _anquPayWayText = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 140, 30)];
    _anquPayWayText.text = [@"支付金额:   " stringByAppendingFormat:@"%@",[OrderInfo sharedSingleton].money];
    _anquPayWayText.font = [UIFont systemFontOfSize:14.0];
    _anquPayWayText.textColor =  UIColorFromRGB(0x666666);
    [_anquScrollView addSubview:_anquPayWayText];
    
    _anquPayValue = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 80, 30)];
    _anquPayValue.text = _anquPayOneCardText.text;
    _anquPayValue.text = _headTitle;
    _anquPayValue.font = [UIFont systemFontOfSize:15.0];
    _anquPayValue.textColor = UIColorFromRGB(0x666666);
    [_anquScrollView addSubview:_anquPayValue];
    
    
    _anquCashValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 200, 30)];
    _anquCashValue.text = @"请选择卡面值:";
    _anquCashValue.font = [UIFont systemFontOfSize:14.0];
    _anquCashValue.textColor = UIColorFromRGB(0x666666);
    [_anquScrollView addSubview:_anquCashValue];
    
#pragma mark -InitButton
     [self initWithButton];
    
//    _anquTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 245, SCREENWIDTH - 30, 30)];
//    _anquTipLabel.textColor = UIColorFromRGB(0xff6600);
//    _anquTipLabel.text = @"注:所选面值与卡实际面值不符时，以卡实际面值为准";
//    _anquTipLabel.font = [UIFont systemFontOfSize:9.0];
//    [_anquScrollView addSubview:_anquTipLabel];
    
//    //交换
//    _anquExchangeBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 285, SCREENWIDTH - 30, 45)];
//    [_anquExchangeBt setBackgroundImage:[GetImage getSmallRectImage:@"anqu_value_bg"] forState:UIControlStateNormal];
//    [_anquExchangeBt setTitle:@"50元可兑换350个元宝" forState:UIControlStateNormal];
//    _anquExchangeBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    [_anquExchangeBt addTarget:self action:@selector(anquLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
//    _anquExchangeBt.userInteractionEnabled = NO;
//    [_anquScrollView addSubview:_anquExchangeBt];
    
     _anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(15, 260, SCREENWIDTH - 30, 100)];
    [_anquEditFrame setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
    [_anquScrollView addSubview:_anquEditFrame];
    
    //卡号
    _anquCardNum = [[UITextField alloc] initWithFrame:CGRectMake(15, 260, SCREENWIDTH - 30, 50)];
    _anquCardNum.placeholder = @" 请输入卡号";
    _anquCardNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquCardNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _anquCardNum.delegate = self;
    [_anquScrollView addSubview:_anquCardNum];
    
    _inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(15, 310, SCREENWIDTH - 30, 1)];
    [_inputSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_split_line"]];
    [_anquScrollView addSubview:_inputSpliterLine];
    
    //密码
    _anquCardPwd = [[UITextField alloc] initWithFrame:CGRectMake(15, 310, SCREENWIDTH - 30, 50)];
    _anquCardPwd.placeholder = @" 请输入充值卡密码";
    _anquCardPwd.delegate = self;
    [_anquCardPwd setSecureTextEntry:TRUE];
    _anquCardPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquCardPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_anquScrollView addSubview:_anquCardPwd];
    
    _anquTip = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 120, 370, 20, 20)];
    _anquTip.image = [GetImage getSmallRectImage:@"anqu_pay_warning"];
    [_anquScrollView addSubview:_anquTip];
    
    _anquTibPayBt = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 100, 370, 50, 20)];
    [_anquTibPayBt setTitle:@"充值说明" forState:UIControlStateNormal];
    [_anquTibPayBt setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    _anquTibPayBt.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_anquTibPayBt addTarget:self action:@selector(anquPayTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquScrollView addSubview:_anquTibPayBt];
    
    _anquCommit = [[UIButton alloc] initWithFrame:CGRectMake(15, 400, SCREENWIDTH - 30, 50)];
    [_anquCommit setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquCommit setTitle:@"确定支付" forState:UIControlStateNormal];
    _anquCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_anquCommit addTarget:self action:@selector(anqucardCommitClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
//    _anquCommit.userInteractionEnabled = NO;
    [_anquScrollView addSubview:_anquCommit];
}

//横屏
#pragma mark -Land
-(void)initPayValueLand
{
    DDLogDebug(@"横屏卡设置++++");
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
    
    _paycardBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,max,min)];
    [_paycardBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
   // [_paycardBgImageView setImage:[GetImage getRectImage:@"anqu_login_bg"]];
    [self.view addSubview:_paycardBgImageView];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(cardPayBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayOneCardText = [[UILabel alloc] initWithFrame:CGRectMake(max/2 - 40, 3, 80, 30)];
    
    if(_paySource == 3){
        _anquPayOneCardText.text = @"移动充值卡";
    }else if(_paySource == 4){
        _anquPayOneCardText.text = @"联通充值卡";
    }else if(_paySource == 5){
        _anquPayOneCardText.text = @"电信充值卡";
    }else if(_paySource == 6){
        _anquPayOneCardText.text = @"骏网充值卡";
    }
    
    _anquPayOneCardText.font = [UIFont systemFontOfSize:15.0];
    _anquPayOneCardText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_anquPayOneCardText];
    
    // NSLog(@"加载支付==%@",_anquPayOneCardText);
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(max - 55, 0, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal]; //anqu_custom
    [_custom addTarget:self action:@selector(cardPayBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, max, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
#pragma mark -ScrollView
    _anquScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, max, min - 30)];
    _anquScrollView.pagingEnabled = YES;
    _anquScrollView.delegate = self;
    _anquScrollView.showsVerticalScrollIndicator = NO;
    _anquScrollView.showsHorizontalScrollIndicator = NO;
    
    CGSize newSize = CGSizeMake(max, min + 100);
    [_anquScrollView setContentSize:newSize];

    
    [self.view addSubview:_anquScrollView];
    
    _anquPayWayText = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 140, 30)];
    _anquPayWayText.text = [@"支付金额:   " stringByAppendingFormat:@"%@",[OrderInfo sharedSingleton].money];
    _anquPayWayText.font = [UIFont systemFontOfSize:14.0];
    _anquPayWayText.textColor =  UIColorFromRGB(0x666666);
    [_anquScrollView addSubview:_anquPayWayText];
    
    _anquPayValue = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 80, 30)];
    _anquPayValue.text = _anquPayOneCardText.text;
    _anquPayValue.text = _headTitle;
    _anquPayValue.font = [UIFont systemFontOfSize:15.0];
    _anquPayValue.textColor = UIColorFromRGB(0x666666);
    [_anquScrollView addSubview:_anquPayValue];
    
    
    _anquCashValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 200, 30)];
    _anquCashValue.text = @"请选择卡面值:";
    _anquCashValue.font = [UIFont systemFontOfSize:14.0];
    _anquCashValue.textColor = UIColorFromRGB(0x666666);
    [_anquScrollView addSubview:_anquCashValue];
    
    //横屏button布局
    [self initWithLandButton];
    
    _anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(15, 160, max - 30, 81)];
    [_anquEditFrame setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
    [_anquScrollView addSubview:_anquEditFrame];
    
    //卡号
    _anquCardNum = [[UITextField alloc] initWithFrame:CGRectMake(15, 160, max - 30, 40)];
    _anquCardNum.placeholder = @" 请输入卡号";
    _anquCardNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquCardNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _anquCardNum.delegate = self;
    [_anquScrollView addSubview:_anquCardNum];
    
    _inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(15, 200, max - 30, 1)];
    [_inputSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_split_line"]];
    [_anquScrollView addSubview:_inputSpliterLine];
    
    //密码
    _anquCardPwd = [[UITextField alloc] initWithFrame:CGRectMake(15, 200, max - 30, 40)];
    _anquCardPwd.placeholder = @" 请输入充值卡密码";
    _anquCardPwd.delegate = self;
    [_anquCardPwd setSecureTextEntry:TRUE];
    _anquCardPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquCardPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_anquScrollView addSubview:_anquCardPwd];
    
    _anquTip = [[UIImageView alloc] initWithFrame:CGRectMake(max - 120, 30, 20, 20)];
    _anquTip.image = [GetImage getSmallRectImage:@"anqu_pay_warning"];
    [_anquScrollView addSubview:_anquTip];
    
    _anquTibPayBt = [[UIButton alloc] initWithFrame:CGRectMake(max - 100, 30, 50, 20)];
    [_anquTibPayBt setTitle:@"充值说明" forState:UIControlStateNormal];
    [_anquTibPayBt setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    _anquTibPayBt.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_anquTibPayBt addTarget:self action:@selector(anquPayTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquScrollView addSubview:_anquTibPayBt];
    
    _anquCommit = [[UIButton alloc] initWithFrame:CGRectMake(15, 250, max - 30, 40)];
    [_anquCommit setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquCommit setTitle:@"确定支付" forState:UIControlStateNormal];
    _anquCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_anquCommit addTarget:self action:@selector(anqucardCommitClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    //    _anquCommit.userInteractionEnabled = NO;
    [_anquScrollView addSubview:_anquCommit];
 
}

#pragma mark -PoritButton
-(void)initWithButton
{
    int count = 1;
    if(_paySource == 6){ //骏网卡
      for (int i = 1; i< 5; i++)
        {
            // NSLog(@"herererer2==%d",count); // 1  6  11
            for (int j = 1; j < 4; j++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                NSString *title = [self.cashArray objectAtIndex:count - 1];
                [button setTag:count];
                count++;
                [button setTitle:title forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14.0];
                [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
                [button setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(selectCashButton:) forControlEvents:UIControlEventTouchUpInside];
                
                if (i == 1)//1
                {
                    button.frame = CGRectMake(100*j - 85, 80, 90, 30);
                }
                else if(i == 2)//2
                {
                    button.frame = CGRectMake(100*j - 85, 120, 90, 30);
                }
                else if(i == 3)//3
                {
                    button.frame = CGRectMake(100*j - 85, 160, 90, 30);
                }
                else if(i == 4)//4
                {
                    button.frame = CGRectMake(100*j - 85, 200, 90, 30);
                }else{
                    NSLog(@"herererer==%d",count);
                    button.frame = CGRectMake(100*j - 85, 240, 90, 30);

                }
                
                [_anquScrollView addSubview:button];
            }
        }

    }
  else{
    for (int i = 1; i< 4; i++)
    {
        for (int j = 1; j < 4; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *title = [self.cashArray objectAtIndex:count - 1];
            [button setTag:count];
            count++;
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            [button setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectCashButton:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 1)//1
            {
                button.frame = CGRectMake(100*j - 85, 80, 80, 45);
            }
            else if(i == 2)//2
            {
                button.frame = CGRectMake(100*j - 85, 130, 80, 45);
            }
            else if(i == 3)//3
            {
                button.frame = CGRectMake(100*j - 85, 180, 80, 45);
            }
            [_anquScrollView addSubview:button];
        }
    }
    }
    
}

#pragma mark -LandButton
-(void)initWithLandButton
{
    int count = 1;
    //@"5元", @"6元",@"10元", @"15元",@"20元", @"30元", @"50元", @"100元", @"200元", @"300元", @"500元",@"1000元"
    if(_paySource ==6){  //骏网卡
        for (int i = 1; i < 4; i++)
        {
            for (int j = 1; j < 6; j++) {
                if (count > 12) {
                    DDLogDebug(@"juwang这里");
                    break;
                }
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                NSString *title = [self.cashArray objectAtIndex:count - 1];
                [button setTag:count];
                count++;
                [button setTitle:title forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14.0];
                [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
                [button setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(selectCashButton:) forControlEvents:UIControlEventTouchUpInside];
                
                if (i == 1)//1行
                {
                    button.frame = CGRectMake(60*j - 45, 40, 50, 40);//90*j - 75
                }
                else if (i == 2)//2行
                {
                    button.frame = CGRectMake(60*j - 45, 90, 50, 40);
                }
                else//3行
                {
                    button.frame = CGRectMake(60*j - 45, 140, 50, 40);

                }
                
                [_anquScrollView addSubview:button];
            }
        }

        
    } else{
//        NSLog(@"这里shenzhoufu神州付");
//@"10元", @"20元", @"30元", @"50元", @"100元", @"150元", @"200元", @"300元", @"500元"
        for (int i = 1; i < 3; i++)
        {
            DDLogDebug(@"这里shenzhoufu神州付count=%d",count);

            for (int j = 1; j < 8; j++) {
                if (count > 9) {
                    break;
                }
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                NSString *title = [self.cashArray objectAtIndex:count - 1];
                [button setTag:count];
                count++;
                [button setTitle:title forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14.0];
                [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
                [button setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(selectCashButton:) forControlEvents:UIControlEventTouchUpInside];
                
                if (i == 1)//1行
                {
                    button.frame = CGRectMake(60*j - 45, 65, 50, 40);//90*j - 75
                }
                else//2行
                {
                    button.frame = CGRectMake(60*j - 45, 115, 50, 40);
                }
                
                [_anquScrollView addSubview:button];
            }
        }
    }
   }

-(void)anquPayTipClick:(id)sender
{
    switch (_paySource) {
        case 3:
            tipValue = YIDONG_SERVER;
            break;
        case 4:
            tipValue = LIANTONG_SERVER;
            break;
            
        case 5:
            tipValue = LIANTONG_SERVER;
            break;
            
        case 6:
            tipValue = SHENGDA_SERVER;
            break;
            
        default:
            tipValue = SHENGDA_SERVER;
            break;
    }
    QutoPayTip *tip = [[QutoPayTip alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    [self.view addSubview:tip];
    
}

//back
-(void)cardPayBackClick:(id)sender
{
    //支付取消callback
    if([OrderInfo sharedSingleton].paystatus!=AnquPayResultCodeSucceed || [OrderInfo sharedSingleton].paystatus != AnquPayResultCodeFail){
        [OrderInfo sharedSingleton].paystatus=AnquPayResultCodeCancel;
        NSLog(@"支付取消");
        [[AnquInterfaceKit sharedInstance].delegate AnquPayResult:AnquPayResultCodeCancel];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)selectCashButton:(id)sender
{
    if (_FlastSelectbutton) {//是否最后一次选中
        [_FlastSelectbutton setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
    }
    UIButton *AButton=sender;
    [AButton setBackgroundImage:[GetImage getPayRectImage:@"anqu_pay_choose"] forState:UIControlStateNormal];
    _FlastSelectbutton=AButton;
    
    
    NSString *btValue = [_cashArray objectAtIndex:_FlastSelectbutton.tag - 1]; //面值
    NSRange range = [btValue rangeOfString:@"元"]; //获取要截取的字符串位置
    [OrderInfo sharedSingleton].cardNorMoney = [btValue substringToIndex:range.location]; //截取字符串
    
    //兑换率
//    int mRatio = [CoinRatio sharedSingleton].ratio;
//    NSLog(@"mRatio = %d", mRatio);
//    NSString *btValue = [_cashArray objectAtIndex:_FlastSelectbutton.tag - 1];
//    NSString *cashValue = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@可以兑换%d元宝", btValue, [btValue intValue]*mRatio]];
//    [_anquExchangeBt setTitle:cashValue forState:UIControlStateNormal];
}

//提交按钮
-(void)anqucardCommitClick:(id)sender
{
    if (_anquCardNum.text.length == 0) {
        [UserData showMessage:@"卡号不能为空"];
        return;
    }
    
    if(_anquCardNum.text.length > 25){
        [UserData showMessage:@"卡号长度不能超过25"];
        return;
    }
    
    if(_anquCardPwd.text.length > 25){
        [UserData showMessage:@"密码长度不能超过25"];
        return;
    }
    
    if(_anquCardPwd.text.length == 0){
        [UserData showMessage:@"密码不能为空"];
        return;
    }
    
    _aliPost = [[httpRequest alloc] init];
    _aliPost.dlegate = self;
    
//    switch (_payway) {
//        case 5:
//        {
//            _strPayWay = CHAIN_UNC_PAYWAY;
//            _payUrl = HTMLWAPPAY_URL;
//        }
//            break;
//        default:
//            _strPayWay = ALIPAY_CREDIT_PAYWAY;
//            _payUrl = HTMLWAPPAY_URL;
//            break;
//    }
    
    [OrderInfo sharedSingleton].cardNo = _anquCardNum.text;
    [OrderInfo sharedSingleton].cardpass = _anquCardPwd.text;
   // NSLog(@"此处cardno=%@，cardpwd=%@",[OrderInfo sharedSingleton].cardNo,[OrderInfo sharedSingleton].cardpass);
    
    //设置loading
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.dimBackground = YES;
    _HUD.labelText = @"请求安全支付中...";
    [OrderInfo sharedSingleton].HUD =_HUD;
    //[_HUD show: YES];
    
    [[AnquInterfaceKit sharedInstance] anquRequestedpay:_payway hubView:_HUD];//初始支付请求

}

+(void) paywithSZF:(MBProgressHUD *)hub
{
    // 实际支付请求处理，包裹成方法供kit.m调用
    NSString *source = @"";
    NSString *sign = @"";
   // NSString *mTime = [[AppInfo sharedSingleton] getData];
    
    //NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
   // _cardmoney = _FlastSelectbutton.titleLabel.text; //面值
    NSString *verifyType = @"1"; //MD5校验
    NSString *version = @"3";
    NSString *merId = @"172802";//商户号
    NSString *returnUrl = @"http://42.62.30.107:10055/index.php/shenzhoufu/Notifyurl/";
    NSString *privateKey = @"BehVLQHz";
    NSString *MerchantName = @"安趣科技有限公司";
    NSString *cardType = [PayOneCard getCardtype:[OrderInfo sharedSingleton].cardNo Cardpw:[OrderInfo sharedSingleton].cardpass];
    
    //@"30@14371120104461316@121573894029953158";
    source = [source stringByAppendingFormat:@"%@@%@@%@",[OrderInfo sharedSingleton].cardNorMoney,[OrderInfo sharedSingleton].cardNo,[OrderInfo sharedSingleton].cardpass];
    NSData *source_data = [source dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [PayOneCard DESEncrypt:source_data WithKey:@"3wQfnXPIEAI="];
    NSString *encrptedInfo = [data base64EncodedStringWithOptions:0];
    
//    NSData *sourcetest = [@"10@0841222799716@114514115" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *datatest = [PayOneCard DESEncrypt:sourcetest WithKey:@"fNCrhSynUm4="];
//    NSString *encrptedtest = [datatest base64EncodedStringWithOptions:0];

    DDLogDebug(@"神州付source=%@,base64_result:%@", source,encrptedInfo);
    
    NSString *privateField = [self getPrivateField];
    float money = [[OrderInfo sharedSingleton].money floatValue]*100;
    int IntMoney = (int)money;
    NSString *payMoney =  [NSString stringWithFormat:@"%d",IntMoney];
    
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@%@", version,merId,payMoney,[OrderInfo sharedSingleton].anquOrderid,returnUrl, encrptedInfo, privateField, verifyType,privateKey];
    
    DDLogDebug(@"Md5 sign = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:version, @"version",merId, @"merId",payMoney,@"payMoney",
                                [OrderInfo sharedSingleton].anquOrderid, @"orderId",
                                returnUrl, @"returnUrl",
                                encrptedInfo, @"cardInfo",
                                MerchantName, @"merUserName",
                                privateField, @"privateField",
                                verifyType, @"verifyType",
                                cardType, @"cardTypeCombine",
                                [MyMD5 md5:sign], @"md5String",nil];
    
    NSString *postData = [dictionary buildQueryString];
    
    DDLogDebug(@"神州付postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(cardpay_callback:);
    _request.error = @selector(cardpay_error);
    [_request post:API_URL_SZF argData:postData]; //API_URL_COIN
    
    //    _payDelegateUrl = [_payUrl stringByAppendingFormat:@"%@%@", @"?", postData];
    //    PayWebView *paywebHtml = [[PayWebView alloc] init];
    //    paywebHtml.payway = _payway;
    //    paywebHtml.webUrl = _payDelegateUrl;
    //    [self presentModalViewController:paywebHtml animated:YES];
}


+(NSString *)getCardtype:(NSString *)cardno Cardpw:(NSString*)password
{
    NSString *cardType=@"";
    NSUInteger cardlen = cardno.length;
    NSUInteger pwdlen = password.length;
    if((cardlen == 16 && pwdlen == 17)||(cardlen == 16 && pwdlen ==21) ||(cardlen == 17 && pwdlen ==18) || (cardlen == 10 && pwdlen == 8))
        cardType = @"0"; //移动卡
    else if(cardlen == 15 && pwdlen == 19) cardType = @"1";
    else if(cardlen == 19 && pwdlen == 18) cardType = @"2";
    
    return cardType;

}

+(NSString *) getPrivateField
{
    //实例化NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"MMddHHmmss"];
    
    //[NSDate date]获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    DDLogDebug(@"神州付私有串为%@",currentDateStr);
    
    return currentDateStr;
    //alloc后对不使用的对象别忘了release
    //[dateFormatter release];
}

+(NSString *)TripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSString *)encryptOrDecryptKey
{
    const void *vplainText;
    size_t plainTextBufferSize;
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        // NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        //        plainTextBufferSize = [EncryptData length];
        //        vplainText = [EncryptData bytes];
     }else //加密
     {
         NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
         plainTextBufferSize = [data length];
         vplainText = (const void *)[data bytes];
       }
        CCCryptorStatus ccStatus;
        uint8_t *bufferPtr = NULL;
        size_t bufferPtrSize = 0;
        size_t movedBytes = 0;
    
        bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
        bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
        memset((void *)bufferPtr, 0x0, bufferPtrSize);
        // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
        const void *vkey = (const void *)[encryptOrDecryptKey UTF8String];
        // NSString *initVec = @"init Vec";
        //const void *vinitVec = (const void *) [initVec UTF8String];
        //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
        ccStatus = CCCrypt(encryptOrDecrypt,
                                            kCCAlgorithm3DES,
                                            kCCOptionPKCS7Padding | kCCOptionECBMode,
                                            vkey,
                                            kCCKeySize3DES,
                                            nil,
                                            vplainText,
                                            plainTextBufferSize,
                                            (void *)bufferPtr,
                                            bufferPtrSize,
                                            &movedBytes);
        //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
        /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
              else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
              else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
              else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
              else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
              else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
        NSString *result;
    
        if (encryptOrDecrypt == kCCDecrypt)
        {
            result = [ [NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
            }
        else
        {
            NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
            result = [PayOneCard hexStringFromData:myData];
        }
    
        return result;
}

+ (NSString *)hexStringFromData:(NSData *)data{
   // NSData *myD = [data dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];   
    }   
    return hexStr;   
}

//骏网卡支付
+(void) paywithJWK:(MBProgressHUD *)hub
{
    NSString *charset = @"gb2312";
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
 
    NSString *agentId = @"1747971";
    NSString *cardtype= @"10"; //骏网一卡通支付
  
    //NSString *requestUrl= @"https://pay.Heepay.com/Api/CardPaySubmitService.aspx?";
    NSString *notify_url = @"http://42.62.30.107:10055/index.php/junkapay/Notifyurl/";
    NSString *DES3KEY = @"6B114551874744F2938D7134";
    NSString *md5key = @"70B52A82B9084F56B83B848C";
    
    NSString *carddata =@"";

    carddata = [carddata stringByAppendingFormat:@"%@,%@,%@",[OrderInfo sharedSingleton].cardNo,[OrderInfo sharedSingleton].cardpass,[OrderInfo sharedSingleton].cardNorMoney];
    
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gb2312data = [carddata dataUsingEncoding:encoding];
    NSString *retStr = [[NSString alloc] initWithData:gb2312data encoding:encoding];
    
    NSString *decrptStr = [PayOneCard TripleDES:retStr encryptOrDecrypt:kCCEncrypt encryptOrDecryptKey:DES3KEY];
    
    //@"30@14371120104461316@121573894029953158";
    DDLogDebug(@"骏网卡decrptStr=%@",decrptStr);
    
//    float money = [[OrderInfo sharedSingleton].money floatValue]*100;
//    int IntMoney = (int)money;
//    NSString *payMoney =  [NSString stringWithFormat:@"%d",IntMoney];
    
    sign = [sign stringByAppendingFormat:@"agent_id=%@&bill_id=%@&bill_time=%@&card_type=%@&card_data=%@&pay_amt=%@&notify_url=%@&time_stamp=%@|||%@", agentId,[OrderInfo sharedSingleton].anquOrderid,[OrderInfo sharedSingleton].ordertime,cardtype,[PayOneCard URLEncodedStringJWK:decrptStr] ,[OrderInfo sharedSingleton].money,notify_url,[OrderInfo sharedSingleton].ordertime,md5key];
    
    DDLogDebug(@"骏网卡Md5 sign = %@",[MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:agentId,@"agent_id",
                                [OrderInfo sharedSingleton].anquOrderid, @"bill_id",
                                [OrderInfo sharedSingleton].ordertime,@"bill_time",
                                cardtype, @"card_type",
                                [PayOneCard URLEncodedStringJWK:decrptStr], @"card_data",
                                [OrderInfo sharedSingleton].money, @"pay_amt",
                                [IPAddress getIPAddress:TRUE], @"client_ip",
                                notify_url, @"notify_url",
                                [OrderInfo sharedSingleton].ordertime, @"time_stamp",
                                [MyMD5 md5:sign],@"sign",nil];
    
    NSString *postData = [dictionary buildQueryString];
    
    DDLogDebug(@"骏网卡postData = %@", postData);
    
    httpGBRequest *_request = [[httpGBRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(jwkpay_callback:);
    _request.error = @selector(cardpay_error);
    [_request postGBK:API_URL_JWK argData:postData];
 
}

+ (NSString *)URLEncodedStringJWK:(NSString *)inputData
{
    
      NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)inputData, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingGB_18030_2000 );
    

    return encodedString;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

-(void)viewWillAppear:(BOOL)animated
{
    // 汇率信息。。。
}

+(void)cardpay_error
{
//    if (hub != NULL) {
//        [hub hide:YES];
//    }
    sleep(2);
    [[OrderInfo sharedSingleton].HUD hide:YES];
    
    [UserData showMessage:@"网络连接超时"];
    [[AnquInterfaceKit sharedInstance].delegate AnquPayResult:AnquPayResultCodeFail];
    
    return;
}

+(void)cardpay_callback:(NSString*)result
{
    //NSLog(@"ratio =%@",result);
    
    NSString *responseCode = [result substringToIndex:3];
    DDLogDebug(@"神州付返回码==%@",responseCode);
    
    sleep(3);
    [[OrderInfo sharedSingleton].HUD hide:YES];

    [UserData updateOrderInfo];

     [[OrderInfo sharedSingleton] setPayname:@"神州付"];
    
    if([responseCode isEqualToString:@"200"]){         //这里是成功的statuscode  进行callback
        [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeSucceed;
        [UserData showMessage:paysuccessTip];
        [[AnquInterfaceKit sharedInstance].delegate AnquPayResult:AnquPayResultCodeSucceed];
        DDLogInfo(@"--神州付支付成功");
        return;
        
    }else{          //失败的statuscode  进行callback
        [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeFail;
        [[AnquInterfaceKit sharedInstance].delegate AnquPayResult:AnquPayResultCodeFail];
        
        [UserData showMessage:[NSString stringWithFormat:@"本次支付失败.%@",payreturnTip]];
         DDLogError(@"--神州付支付失败");
        return;
        
    }
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSDictionary *rootDic = [parser objectWithString:result];
//    NSDictionary *data = [rootDic objectForKey:@"data"];
//    NSString *coin_name = [data objectForKey:@"coin_name"];
//    NSString *ratio = [data objectForKey:@"ratio"];
//    [[CoinRatio sharedSingleton] initWithType:coin_name Ratio:[ratio intValue]];
}

+(void)jwkpay_callback:(NSString*)result
{
//    ret_code=0&agent_id=1747971&bill_id=915390000001506&jnet_bill_no=H1504133259649AM&bill_status=1&card_real_amt=0.01&card_settle_amt=0&card_detail_data=1404244879733426=1&ret_msg=支付成功&ext_param=&sign=8a2d7c00ad2642db1326e583521412a4
    
    NSRange coderange = [result rangeOfString:@"ret_code="];
    NSRange aidrange = [result rangeOfString:@"&agent_id"]; //获取responseCode位置
    NSRange statusrange = [result rangeOfString:@"&bill_status="];
    NSRange cardrange = [result rangeOfString:@"&card_real_amt"];
    
    NSRange rangeForcode = NSMakeRange(coderange.location+coderange.length,aidrange.location-coderange.length);
    NSString *responseCode = [result substringWithRange:rangeForcode]; //截取字符串responseCode
    
    NSRange rangeForStatus = NSMakeRange(statusrange.location+statusrange.length,1);
    NSString *status = [result substringWithRange:rangeForStatus];
    DDLogDebug(@"骏网卡返回==%@,responseCode=%@,status=%@",result,responseCode,status);
    
    [UserData updateOrderInfo];
     [[OrderInfo sharedSingleton] setPayname:@"骏网卡"];

    if ([responseCode isEqualToString:@"0"]&&[status isEqualToString:@"1"]) {
        [[OrderInfo sharedSingleton].HUD hide:YES];
        [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeSucceed;
        [UserData showMessage:paysuccessTip];
        [[AnquInterfaceKit sharedInstance].delegate AnquPayResult:AnquPayResultCodeSucceed];
        
        DDLogInfo(@"骏网卡支付成功");
        return;

    }else{
        [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeFail;
        [[AnquInterfaceKit sharedInstance].delegate AnquPayResult:AnquPayResultCodeFail];
        [[OrderInfo sharedSingleton].HUD hide:YES];
        
        [UserData showMessage:[NSString stringWithFormat:@"本次支付失败.%@",payreturnTip]];
        DDLogError(@"骏网卡支付失败");
        return;
    }
    
//    [OrderInfo sharedSingleton].transNum = [result substringWithRange:rangeForOrderId];
//    String responseCode = BaseUtils.getContent(result,"ret_code=","&agent_id");
//    String responseMessage = BaseUtils.getContent(result,"&ret_msg=","&ext_param");
//    String jwangorderId =  BaseUtils.getContent(result,"&jnet_bill_no=","&bill_status");
//    String statuscode= BaseUtils.getContent(result,"&bill_status=","&card_real_amt");
    //responseCode==0   statuscode==1  成功

}


//建议变成 静态方法
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCKeySizeAES256;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    NSData *keyData = [[NSData alloc] initWithBase64EncodedString:key options:0];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode ,
                                          [keyData bytes], kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
      DDLogDebug(@"加密的data=%@，key=%@,keydata=%@,cryptStatus=%d",data,key,keyData,cryptStatus);
    
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode ,
//                                          keyPtr, kCCBlockSizeDES,
//                                          NULL,
//                                          [data bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesEncrypted);
//     NSLog(@"加密的data=%@，key=%@,cryptStatus=%d",data,key,cryptStatus);

    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

#pragma -mark UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {//如果机型是iPhone
        
        if (UIInterfaceOrientationIsPortrait( _orientation)) {//是竖屏
            offset = frame.origin.y + 200 - (self.view.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 180 - (self.view.frame.size.height -216.0);
        }
        
    }else{//机型是ipad
        if (UIInterfaceOrientationIsPortrait( _orientation)) {//是竖屏
            offset = frame.origin.y + 100 - (self.view.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 190 - (self.view.frame.size.height -216.0);
        }
        
    }
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard"context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        if (UIInterfaceOrientationIsPortrait( _orientation)) {//是竖屏
            self.view.frame =CGRectMake(0.0f, -offset,self.view.frame.size.width,self.view.frame.size.height);//-offset 0.0f
        }else{
            self.view.frame =CGRectMake(offset, 0.0f,self.view.frame.size.width,self.view.frame.size.height);//-offset 0.0f
        }
    
    [UIView commitAnimations];
    
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
}

//触摸view隐藏键盘——touchDown

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return NO;
}


//iOS 6.0旋屏支持方向
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


//iOS 6.0以下旋屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    }
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



