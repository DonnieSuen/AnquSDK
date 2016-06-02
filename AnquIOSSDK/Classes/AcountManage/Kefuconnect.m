//
//  Kefuconnect.m
//  anquFramework
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "Kefuconnect.h"

@interface Kefuconnect ()

@end

@implementation Kefuconnect

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
    [self initkefuManual];
    
    if (UIInterfaceOrientationIsLandscape(_orientation))
    {
        [self initkefuManualLand];
    }
    
    // Do any additional setup after loading the view.
}

-(void)initkefuManual
{
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 70)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anqukefuBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anqukefuText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 70)];
    _anqukefuText.text = @"客服信息";
    _anqukefuText.font = [UIFont systemFontOfSize:15.0];
    _anqukefuText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_anqukefuText];
    
    _anquclose = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 70)];
    [_anquclose setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    [_anquclose addTarget:self action:@selector(anqukefuBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_anquclose];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    
    _anquFrameView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, SCREENWIDTH - 20, 250)];
    [_anquFrameView setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
    _anquFrameView.userInteractionEnabled = YES;
    [_anquFrameView setClipsToBounds:YES];
    [self.view addSubview:_anquFrameView];
    
    _anquUnderLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36, SCREENWIDTH - 20, 1)];
    _anquUnderLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [_anquFrameView addSubview:_anquUnderLine];
    
#pragma mark -Frame
    
    //
    _kefuphone = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/2 - 10, 35)];
    [_kefuphone setTitle:@"客服电话" forState:UIControlStateNormal];
    _kefuphone.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_kefuphone setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    _kefuphone.tag = 1;
    [_kefuphone setBackgroundImage:[GetImage getSmallRectImage:@"anqu_pay_choose"] forState:UIControlStateNormal];
    
    [_kefuphone addTarget:self action:@selector(anqukefuClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquFrameView addSubview:_kefuphone];
    
    //
    _kefuemail = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 10, 0, SCREENWIDTH/2 - 10, 35)];
    [_kefuemail setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_kefuemail setTitle:@"客服邮箱" forState:UIControlStateNormal];
    _kefuemail.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _kefuemail.tag = 2;
    [_kefuemail addTarget:self action:@selector(anqukefuClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquFrameView addSubview:_kefuemail];
    
    
    _anqukefuName = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 85, 260, 30)];
    _anqukefuName.text = @"联系电话：0773-3560663";
    _anqukefuName.font = [UIFont systemFontOfSize:22.0];
    _anqukefuName.textColor = UIColorFromRGB(0xff6600);
    [_anquFrameView addSubview:_anqukefuName];
    
    _anquKefuTime = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 165, 260, 30)];
    _anquKefuTime.text = @"服务时间: 09:00 - 24:00";
    _anquKefuTime.font = [UIFont systemFontOfSize:22.0];
    _anquKefuTime.textColor = UIColorFromRGB(0xff6600);
    [_anquFrameView addSubview:_anquKefuTime];
    
    
}

#pragma mark -Land
-(void)initkefuManualLand
{
    [_back setFrame:CGRectMake(5, 2, 50, 30)];
    
    [_anqukefuText setFrame:CGRectMake(SCREENWIDTH/2 - 40, 2, 80, 30)];
    
    [_anquclose setFrame:CGRectMake(SCREENWIDTH - 55, 2, 50, 30)];
    
    [_anquSplitLine setFrame:CGRectMake(0, 32, SCREENWIDTH, 1)];
    
    [_anquChooseLabel setFrame:CGRectMake(SCREENWIDTH/2 - 100, 35, 200, 20)];
    
    [_anquFrameView setFrame:CGRectMake(10, 60, SCREENWIDTH - 20, 200)];
    
    [_anquUnderLine setFrame:CGRectMake(0, 30, SCREENWIDTH - 20, 1)];
    
    [_kefuphone setFrame:CGRectMake(0, 0, SCREENWIDTH/2 - 10, 35)];
    [_kefuemail setFrame:CGRectMake(SCREENWIDTH/2 -10, 0, SCREENWIDTH/2 - 10, 35)];
    
#pragma mark -Frame
   // [_anquLocation setFrame:CGRectMake(SCREENWIDTH/2 - 130, 40, 260, 20)];
    [_anqukefuName setFrame:CGRectMake(50, 65, SCREENWIDTH/2+SCREENWIDTH/4, 30)];
    [_anquKefuTime setFrame:CGRectMake(50, 115, SCREENWIDTH/2+SCREENWIDTH/4, 30)];
    
//    [_anquQQ setFrame:CGRectMake(SCREENWIDTH/2, 265, 150, 30)];
//    [_anquWeixin setFrame:CGRectMake(10, 290, 150, 20)];
    
}

-(void)anqukefuClick:(id)sender
{
    if (_FlastSelectbutton) {//是否最后一次选中
        [_FlastSelectbutton setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
    }
    UIButton *AButton=sender;
    [AButton setBackgroundImage:[GetImage getPayRectImage:@"anqu_pay_choose"] forState:UIControlStateNormal];
    _FlastSelectbutton=AButton;
    
    switch (_FlastSelectbutton.tag) {
        case 1:
            _anqukefuName.text = @"联系电话：0773-3560663";
            break;
            
        case 2:
            _anqukefuName.text = @"QQ邮箱：2850581270@qq.com";
            break;
            
            
        default:
            break;
    }
}

//back
-(void)anqukefuBackClick
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
