//
//  QutoPayTip.m
//  anquFramework
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.


#import "QutoPayTip.h"

@interface QutoPayTip ()

@end

@implementation QutoPayTip

extern NSString *tipValue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        [self initLoginView];
    }
    return self;
}

-(void)initLoginView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
 
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgView.backgroundColor = [UIColor darkTextColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 45, 45)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anquTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquTipBgView addSubview:_back];
    
    _anquTipBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
    //    _anquLoginBgView.userInteractionEnabled = YES;
    [self addSubview:_anquTipBgView];
    
    _anquTipBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
    [_anquTipBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_anquTipBgImageView setImage:[GetImage getRectImage:@"anqu_login_bg"]];
    [_anquTipBgView addSubview:_anquTipBgImageView];
    
    
    UILabel *anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 25, 25, 100, 25)];
    anquTitle.textColor = UIColorFromRGB(0xFF6600);
    anquTitle.font = [UIFont systemFontOfSize:22.0];
    anquTitle.text = @"提  示";
    [_anquTipBgView addSubview:anquTitle];
    
    _close = [[UIButton alloc] initWithFrame:CGRectMake(bg_width - 60, 15, 45, 45)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(anquTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquTipBgView addSubview:_close];
    
    _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, 292, 1)];
    [_anquSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_split_line"]];
    [_anquTipBgView addSubview:_anquSpliterLine];
    
    UIImageView *anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 280, 140)];
    [anquEditFrame setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
    anquEditFrame.userInteractionEnabled = YES;
    [_anquTipBgView addSubview:anquEditFrame];
    
    _tipContent = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 260, 120)];
    _tipContent.userInteractionEnabled = YES;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[tipValue dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _tipContent.attributedText = attributedString;
    _tipContent.scrollEnabled = YES;
    _tipContent.editable = NO;
    [anquEditFrame addSubview:_tipContent];
    
    
    //立即登陆
    _anquTipBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 230, 280, 35)];
    [_anquTipBt setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquTipBt setTitle:@"确定" forState:UIControlStateNormal];
    _anquTipBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_anquTipBt addTarget:self action:@selector(anquTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquTipBgView addSubview:_anquTipBt];
}

-(void)anquTipClick:(id)sender
{
    [self removeFromSuperview];
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

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

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
