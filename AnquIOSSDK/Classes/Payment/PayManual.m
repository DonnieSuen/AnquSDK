//
//  PayManual.m
//  anquFramework
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "PayManual.h"

@interface PayManual ()

@end

@implementation PayManual

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    [self initPayManual];
    
    if (_orientation != UIDeviceOrientationPortrait)
    {
        [self initPayManualLand];
    }
    
    // Do any additional setup after loading the view.
}

-(void)initPayManual
{
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anquPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 30)];
    _anquPayText.text = @"人工充值";
    _anquPayText.font = [UIFont systemFontOfSize:15.0];
    _anquPayText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_anquPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 30)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(anquPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    _anquChooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 50, 200, 30)];
    _anquChooseLabel.text = @"请选择对应的开户银行";
    _anquChooseLabel.font = [UIFont systemFontOfSize:15.0];
    _anquChooseLabel.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquChooseLabel];
    
    _anquFrameView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, SCREENWIDTH - 20, 250)];
    [_anquFrameView setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
    _anquFrameView.userInteractionEnabled = YES;
    [_anquFrameView setClipsToBounds:YES];
    [self.view addSubview:_anquFrameView];
    
    _anquUnderLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36, SCREENWIDTH - 20, 1)];
    _anquUnderLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [_anquFrameView addSubview:_anquUnderLine];
    
#pragma mark -Frame
    
    //工商银行
    _icbc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/4 - 5, 35)];
    [_icbc setTitle:@"工商银行" forState:UIControlStateNormal];
    _icbc.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_icbc setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    _icbc.tag = 1;
    [_icbc addTarget:self action:@selector(anquBankClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquFrameView addSubview:_icbc];
    
    //招商银行
    _cmbc = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/4 - 5, 0, SCREENWIDTH/4 - 5, 35)];
    [_cmbc setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_cmbc setTitle:@"招商银行" forState:UIControlStateNormal];
    _cmbc.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _cmbc.tag = 2;
    [_cmbc addTarget:self action:@selector(anquBankClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquFrameView addSubview:_cmbc];
    
    //建设银行
    _ccb = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 10, 0, SCREENWIDTH/4 - 5, 35)];
    [_ccb setTitle:@"建设银行" forState:UIControlStateNormal];
    _ccb.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _ccb.tag = 3;
    [_ccb setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_ccb addTarget:self action:@selector(anquBankClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquFrameView addSubview:_ccb];
    
    //农业银行
    _abc = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH*3/4 - 15, 0, SCREENWIDTH/4 - 5, 35)];
    [_abc setTitle:@"农业银行" forState:UIControlStateNormal];
    _abc.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _abc.tag = 4;
    [_abc setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_abc addTarget:self action:@selector(anquBankClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquFrameView addSubview:_abc];
    
    _anquLocation = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 45, 260, 30)];
    _anquLocation.text = @"开户地: 广州";
    _anquLocation.font = [UIFont systemFontOfSize:15.0];
    _anquLocation.textColor = UIColorFromRGB(0x999999);
    [_anquFrameView addSubview:_anquLocation];
    
    _anquBankName = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 85, 260, 30)];
    _anquBankName.text = @"开户行: 建设银行北务创新园工业园支行";
    _anquBankName.font = [UIFont systemFontOfSize:15.0];
    _anquBankName.textColor = UIColorFromRGB(0x999999);
    [_anquFrameView addSubview:_anquBankName];
    
    _anquBankAcount = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 125, 260, 30)];
    _anquBankAcount.text = @"账   号: 安趣信息科技有限公司";
    _anquBankAcount.font = [UIFont systemFontOfSize:15.0];
    _anquBankAcount.textColor = UIColorFromRGB(0x999999);
    [_anquFrameView addSubview:_anquBankAcount];
    
    _anquCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 165, 260, 30)];
    _anquCardLabel.text = @"卡   号: 44001 47051 30530 06982";
    _anquCardLabel.font = [UIFont systemFontOfSize:15.0];
    _anquCardLabel.textColor = UIColorFromRGB(0xff6600);
    [_anquFrameView addSubview:_anquCardLabel];
    
//    _anquCardNum = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 + 130, 165, 260, 30)];
//    _anquCardNum.text = @"44001 47051 30530 06982";
//    _anquCardNum.font = [UIFont systemFontOfSize:15.0];
//    _anquCardNum.textColor = UIColorFromRGB(0xff6600);
//    [_anquFrameView addSubview:_anquCardNum];
    
    _anquTip = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120, 200, 20, 20)];
    _anquTip.image = [GetImage getSmallRectImage:@"anqu_pay_warning"];
    [_anquFrameView addSubview:_anquTip];
    
    _anquTibPayBt = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 200, 50, 20)];
    [_anquTibPayBt setTitle:@"充值说明" forState:UIControlStateNormal];
    [_anquTibPayBt setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    _anquTibPayBt.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_anquTibPayBt addTarget:self action:@selector(yyPayTipClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquFrameView addSubview:_anquTibPayBt];
    
    
    _anquCoustomNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 350, 150, 30)];
    _anquCoustomNum.text = @"客服电话: 020-85166576";
    _anquCoustomNum.font = [UIFont systemFontOfSize:12.0];
    _anquCoustomNum.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquCoustomNum];
    
    _anquQQ = [[UILabel alloc] initWithFrame:CGRectMake(160, 350, 150, 30)];
    _anquQQ.text = @"客服QQ: 23355700639";
    _anquQQ.font = [UIFont systemFontOfSize:12.0];
    _anquQQ.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquQQ];
    
    _anquWeixin = [[UILabel alloc] initWithFrame:CGRectMake(10, 390, 150, 30)];
    _anquWeixin.text = @"客服微信: yxanqu";
    _anquWeixin.font = [UIFont systemFontOfSize:12.0];
    _anquWeixin.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquWeixin];
    
    _anquCustomTime = [[UILabel alloc] initWithFrame:CGRectMake(160, 390, 150, 30)];
    _anquCustomTime.text = @"服务时间: 09:00 - 24:00";
    _anquCustomTime.font = [UIFont systemFontOfSize:12.0];
    _anquCustomTime.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquCustomTime];
    
}

#pragma mark -Land
-(void)initPayManualLand
{
    [_back setFrame:CGRectMake(5, 2, 50, 30)];
    
    [_anquPayText setFrame:CGRectMake(SCREENWIDTH/2 - 40, 2, 80, 30)];
    
    [_custom setFrame:CGRectMake(SCREENWIDTH - 55, 2, 50, 30)];
    
    [_anquSplitLine setFrame:CGRectMake(0, 32, SCREENWIDTH, 1)];
    
    [_anquChooseLabel setFrame:CGRectMake(SCREENWIDTH/2 - 100, 35, 200, 20)];
    
    [_anquFrameView setFrame:CGRectMake(10, 60, SCREENWIDTH - 20, 200)];
    
    [_anquUnderLine setFrame:CGRectMake(0, 30, SCREENWIDTH - 20, 1)];
    
    [_icbc setFrame:CGRectMake(0, 0, SCREENWIDTH/4 - 5, 35)];
    [_cmbc setFrame:CGRectMake(SCREENWIDTH/4 - 5, 0, SCREENWIDTH/4 - 5, 35)];
    [_ccb setFrame:CGRectMake(SCREENWIDTH/2 - 10, 0, SCREENWIDTH/4 - 5, 35)];
    [_abc setFrame:CGRectMake(SCREENWIDTH*3/4 - 15, 0, SCREENWIDTH/4 - 5, 35)];
    
#pragma mark -Frame
    [_anquLocation setFrame:CGRectMake(SCREENWIDTH/2 - 130, 40, 260, 20)];
    [_anquBankName setFrame:CGRectMake(SCREENWIDTH/2 - 130, 65, 260, 20)];
    [_anquBankAcount setFrame:CGRectMake(SCREENWIDTH/2 - 130, 90, 260, 20)];
    [_anquCardLabel setFrame:CGRectMake(SCREENWIDTH/2 - 130, 115, 260, 20)];
    
    [_anquTip setFrame:CGRectMake(self.view.frame.size.width - 120, 140, 20, 20)];
    [_anquTibPayBt setFrame:CGRectMake(self.view.frame.size.width - 100, 140, 50, 20)];
    
    [_anquCoustomNum setFrame:CGRectMake(10, 265, 150, 20)];
    [_anquQQ setFrame:CGRectMake(SCREENWIDTH/2, 265, 150, 30)];
    [_anquWeixin setFrame:CGRectMake(10, 290, 150, 20)];
    [_anquCustomTime setFrame:CGRectMake(SCREENWIDTH/2, 290, 150, 20)];
}

-(void)anquBankClick:(id)sender
{
    if (_FlastSelectbutton) {//是否最后一次选中
        [_FlastSelectbutton setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
    }
    UIButton *AButton=sender;
    [AButton setBackgroundImage:[GetImage getPayRectImage:@"anqu_pay_choose"] forState:UIControlStateNormal];
    _FlastSelectbutton=AButton;
    
    switch (_FlastSelectbutton.tag) {
        case 1:
            _anquBankName.text = @"开户行: 工商银行北务工业园支行";
            break;
            
        case 2:
            _anquBankName.text = @"开户行: 招商银行北务工业园支行";
            break;
            
        case 3:
            _anquBankName.text = @"开户行: 建设银行中关村工业园支行";
            break;
            
        case 4:
            _anquBankName.text = @"开户行: 农业银行中关村工业园支行";
            break;
            
        default:
            break;
    }
}

-(void)yyPayTipClick
{
    tipValue = REGISTER_SERVER;
    QutoPayTip *tip = [[QutoPayTip alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [self.view addSubview:tip];
}

//back
-(void)anquPayBackClick
{
  [self dismissViewControllerAnimated:NO completion:nil];//支付取消callback
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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
