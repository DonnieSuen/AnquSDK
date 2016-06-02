//
//  PayHome.m


//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "PayHome.h"


@interface PayHome ()
@end

@implementation PayHome



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)handleDeviceOrientationDidChange
{
    
    UIDevice *device = [UIDevice currentDevice] ;
    
    switch (device.orientation) {
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"向左橫置");
            _payorietation =  TRUE;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"向右橫置");
            _payorietation =  TRUE;
            break;
            
        case UIDeviceOrientationPortrait:
            NSLog(@"直立");
            _payorietation =  FALSE;
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"上下顛倒");
            _payorietation =  FALSE;
            break;
            
        default:
            NSLog(@"Not Known");
            _payorietation =  UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
            break;
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _orientation = [AnquInterfaceKit getOrientation];
    UIColor *mycolor =[UIColor colorWithWhite:0.5 alpha:0.7];
    self.view.backgroundColor =  mycolor;
    
    [self initPayView];
    

    // Do any additional setup after loading the view.
}


-(void)initPayView{
    
    //支付宝  银联  移动  联通  电信  微信支付(骏网卡)
    _imageNameArray = [NSArray arrayWithObjects:@"anqu_alipay_app", @"anqu_mobile", @"anqu_unicom", @"anqu_189",@"anqu_weixinpay",nil];//@"anqu_junwang" @"anqu_uppay",
    
    _imageNameArrayCh = [NSArray arrayWithObjects:@"anqu_alipay_app_choose",@"anqu_mobile_choose",@"anqu_unicom_choose",@"anqu_189_choose" @"anqu_weixinpay_choose",nil];//@"anqu_junwang_choose"  @"anqu_uppay_choose",
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
    
    if((UIInterfaceOrientationIsLandscape(_orientation) &&(_payorietation == TRUE))){  //UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
        
        NSLog(@"----横屏支付----");
        _anquPayBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,max,min)];
        _anquPayBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_anquPayBgView];
        
        _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
        [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
        [_back addTarget:self action:@selector(anqupaybackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
        [self.view addSubview:_back];
        
        _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(max/2 - 30, 3, 120, 50)];
        _anquPayText.text = @"支付中心";
        _anquPayText.font = [UIFont systemFontOfSize:20.0];
        _anquPayText.textColor = UIColorFromRGB(0x222222);
        [self.view addSubview:_anquPayText];
        
        _custom = [[UIButton alloc] initWithFrame:CGRectMake(max - 55, 5, 50, 50)];
        [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
        [_custom addTarget:self action:@selector(anqupaybackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
        [self.view addSubview:_custom];
        
        _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, max, 1)];
        _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
        [self.view addSubview:_anquSplitLine];
        
        _anquWelText = [[UILabel alloc] initWithFrame:CGRectMake(max/2 - 80, 60, 80, 30)];
        _anquWelText.text = @"欢迎您, ";
        _anquWelText.font = [UIFont systemFontOfSize:16.0];
        _anquWelText.textColor = UIColorFromRGB(0x666666);
        [self.view addSubview:_anquWelText];
        
        _anquUserName = [[UILabel alloc] initWithFrame:CGRectMake(max/2, 60, max/2-80, 30)];
        _anquUserName.text = [AnquUser sharedSingleton].username;
        _anquUserName.font = [UIFont systemFontOfSize:16.0];
        _anquUserName.textColor = UIColorFromRGB(0xff6600);
        [self.view addSubview:_anquUserName];
        
//        _anquChooseWay = [[UILabel alloc] initWithFrame:CGRectMake(SCREENHEIGHT/2 - 100, 100, 200, 20)];
//        _anquChooseWay.text = @"请点击适合您的支付方式";
//        _anquChooseWay.font = [UIFont systemFontOfSize:16.0];
//        _anquChooseWay.textColor = UIColorFromRGB(0x666666);
//        [self.view addSubview:_anquChooseWay];
        
    }
    else{ //竖屏
        NSLog(@"-----到竖屏这里----");
        if ( (_orientation == UIInterfaceOrientationUnknown)) {
             _anquPayBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,min,min)];
        }else{
            _anquPayBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,min,max)];

        }
         _anquPayBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_anquPayBgView];
        
        _back = [[UIButton alloc] initWithFrame:CGRectMake(30, 5, 50, 50)];
        [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
        [_back addTarget:self action:@selector(anqupaybackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
        [_anquPayBgView addSubview:_back];
        
        _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(min/2 - 25, 3, 120, 50)];
        _anquPayText.text = @"支付中心";
        _anquPayText.font = [UIFont systemFontOfSize:16.0];
        _anquPayText.textColor = UIColorFromRGB(0x222222);
        [_anquPayBgView addSubview:_anquPayText];
        
        _custom = [[UIButton alloc] initWithFrame:CGRectMake(min - 55, 5, 50, 50)];
        [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
        [_custom addTarget:self action:@selector(anqupaybackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
        [_anquPayBgView addSubview:_custom];
        
        _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, min, 1)];
        _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
        [self.view addSubview:_anquSplitLine];
        
        NSString * username = @"客官";
        if ([AnquUser sharedSingleton].username!=nil||[AnquUser sharedSingleton].username.length>0) {
            username = [AnquUser sharedSingleton].username;
        }
        ;
        _anquChooseWay = [[UILabel alloc] initWithFrame:CGRectMake(min/6, 60, min*3/4, 50)];
        _anquChooseWay.text = [NSString stringWithFormat:@"欢迎您,%@",username];
        _anquChooseWay.font = [UIFont systemFontOfSize:15.0];
        _anquChooseWay.textColor = UIColorFromRGB(0x666666);
        [_anquPayBgView addSubview:_anquChooseWay];
        
    }
    
    PSTCollectionViewFlowLayout *layout = [[PSTCollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
   if ((UIInterfaceOrientationIsLandscape(_orientation) && (_payorietation == TRUE)) ) {
        NSLog(@"到横屏这里PayWayCollection");
        _anquPayWayCollection = [[PSTCollectionView alloc] initWithFrame:CGRectMake(50, 100, max - 80, min - 110) collectionViewLayout:layout];
   }else if(_orientation == UIInterfaceOrientationUnknown){
       _anquPayWayCollection = [[PSTCollectionView alloc] initWithFrame:CGRectMake(20, 150, min - 20, min - 50) collectionViewLayout:layout];
   }else
    {
        _anquPayWayCollection = [[PSTCollectionView alloc] initWithFrame:CGRectMake(20, 150, min - 20, max - 50) collectionViewLayout:layout];
    }
    _anquPayWayCollection.delegate = self;
    _anquPayWayCollection.dataSource = self;
    [_anquPayWayCollection reloadData];
    _anquPayWayCollection.backgroundColor = [UIColor whiteColor];
    [_anquPayWayCollection registerClass:[CollectionPayCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_anquPayWayCollection];
    

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//back
-(void)anqupaybackClick
{
    //支付取消callback
    if([OrderInfo sharedSingleton].paystatus!=AnquPayResultCodeSucceed || [OrderInfo sharedSingleton].paystatus != AnquPayResultCodeFail){
        [OrderInfo sharedSingleton].paystatus=AnquPayResultCodeCancel;
        NSLog(@"支付取消");
        [_delegate AnquPayResult:AnquPayResultCodeCancel];
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    NSLog(@"hello, world");
}

#pragma mark -
#pragma mark Collection View Data Source

- (NSString *)formatIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionPayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //图片名称
    NSString *imageToLoad = [_imageNameArray objectAtIndex:indexPath.row];
    //加载图片
    [cell.cellButton setImage:[GetImage imagesNamedFromCustomBundle:imageToLoad] forState:UIControlStateNormal];
//    cell.cellButton.image = [GetImage imagesNamedFromCustomBundle:imageToLoad];

    //设置背景色
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(96, 75);
}

- (NSInteger)collectionView:(PSTCollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 5;
}

//UICollectionView被选中时调用的方法
-(BOOL)collectionView:(PSTCollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

//    if ([indexPath row] >= 4 && [indexPath row] < 7) {
//        PayOneCard *oneCard = [[PayOneCard alloc] init];
//        oneCard.payway = [indexPath row];
//        [self presentModalViewController:oneCard animated:YES];
//    }
     if([indexPath row] == 7)
    {
        PayManual *manual = [[PayManual alloc] init];
        manual.payway = (int)[indexPath row] ;
        [self presentModalViewController:manual animated:YES];
    }
    if ([AnquUser sharedSingleton].uid == nil) {
        [UserData showMessage:@"客官,请您先登陆."];
        return;
    }

    
    NSLog(@"选择的支付%ld",(long)[indexPath row]);
 
    switch ([indexPath row]) {
        case 0://支付宝
        {
            PayCreditCard *oneCard = [[PayCreditCard alloc] init];
            oneCard.payway = ALIPAYID;
            oneCard.paySource = 1;
            oneCard.anquPayText = @"支付宝";
            [OrderInfo sharedSingleton].type = ALIPAYID;  //支付渠道
            [self presentModalViewController:oneCard animated:YES];
            break;
        }
//        case 1: //银联
//        {
//            PayCreditCard *value = [[PayCreditCard alloc] init];
//            value.payway = UPPAYID;
//            value.paySource = 2;
//            value.anquPayText = @"银联卡";
//            [OrderInfo sharedSingleton].type = UPPAYID;
//            [self presentModalViewController:value animated:YES];
//            break;
//        }
        case 1://移动卡
        {
            PayOneCard *oneCard = [[PayOneCard alloc] init];
            oneCard.payway = SZFPAYID;
            oneCard.paySource = 3;
            oneCard.anquPayOneCardText = @"移动卡";
            [OrderInfo sharedSingleton].type = SZFPAYID;
            [self presentModalViewController:oneCard animated:YES];
            break;
        }
        case 2://联通卡
        {
            PayOneCard *oneCard = [[PayOneCard alloc] init];
            oneCard.payway = SZFPAYID;
            oneCard.paySource = 4;
            oneCard.anquPayOneCardText = @"联通卡";
            [OrderInfo sharedSingleton].type = SZFPAYID;
            [self presentModalViewController:oneCard animated:YES];
            break;
        }
        case 3://电信卡
        {
            PayOneCard *oneCard = [[PayOneCard alloc] init];
            oneCard.payway = SZFPAYID;
            oneCard.paySource = 5;
            oneCard.anquPayOneCardText = @"电信卡";
            [OrderInfo sharedSingleton].type = SZFPAYID;
            [self presentModalViewController:oneCard animated:YES];
            break;
        }
//        case 5://骏网卡
//        {
//            PayOneCard *oneCard = [[PayOneCard alloc] init];
//            oneCard.payway = JUNWANGPAYID;
//            oneCard.paySource = 6;
//            oneCard.anquPayOneCardText = @"骏网卡";
//           [OrderInfo sharedSingleton].type = JUNWANGPAYID;
//            [self presentModalViewController:oneCard animated:YES];
//            break;
//        }
        case 4://微信支付
        {
            PayCreditCard *weixinpay = [[PayCreditCard alloc] init];
            weixinpay.payway = WEIXINPAYID;
            weixinpay.paySource = 7;
            weixinpay.anquPayText = @"微信支付";
            weixinpay.delegate =_delegate;
            [OrderInfo sharedSingleton].type = WEIXINPAYID;  //支付渠道
            [self presentModalViewController:weixinpay animated:YES];
            break;
        }

            
        default:
            break;
    }
    
    [[OrderInfo sharedSingleton] createDescription];//生成描述
}


- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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
