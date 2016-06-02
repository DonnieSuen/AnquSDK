
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "PayCreditCard.h"
#import "HttpUrl.h"
#import "IPNPreSignMessageUtil.h"
#import "IpaynowPluginApi.h"
#import "SvUDIDTools.h"

@interface PayCreditCard ()
@property (nonatomic, assign) CGFloat framewidth;
@property (nonatomic, assign) CGFloat frameheight;

@end

@implementation PayCreditCard

NSString *_presignStr;
UIAlertView*  mAlert;

int ddLogLevel;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
               // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}
- (void)handleDeviceOrientationDidChange
{
    
    UIDevice *device = [UIDevice currentDevice] ;
    
    switch (device.orientation) {
            
        case UIDeviceOrientationLandscapeLeft:
            _payorietation =  TRUE;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            _payorietation =  TRUE;
            break;
            
        case UIDeviceOrientationPortrait:
            _payorietation =  FALSE;
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            _payorietation =  FALSE;
            break;
            
        default:
            NSLog(@"Not Known");
            _payorietation =  TRUE;
            break;
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _orientation = [AnquInterfaceKit getOrientation];
    ddLogLevel =[AnquInterfaceKit getLoggerLevel];
    _deviceName = [[UIDevice currentDevice] model];
    
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
    
    if (UIInterfaceOrientationIsLandscape(_orientation) && (_payorietation == TRUE))
    {
        _bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, max,min)];
        _bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: _bg];
        [self initComponents];
        [self initPayValueLand];
    }else if(_payorietation == UIInterfaceOrientationUnknown){
        NSLog(@"方向会变化不确定");
        _bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, min, min)];
        _bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: _bg];
        [self initComponents];
        [self initPayValuePortrait];

    }
    else{
        _bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, min, max)];
        _bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: _bg];
          [self initComponents];
         [self initPayValuePortrait];
    }
    
    NSLog(@"支付devicename=%@",_deviceName);
   //  [self performSelectorOnMainThread:@selector(login)withObject:nil waitUntilDone:NO];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initComponents
{
    _back = [[UIButton alloc] init];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(plugPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayText = [[UILabel alloc] init];
    if([_payway isEqualToString:ALIPAYID] ){
        _anquPayText.text = @"支付宝快捷";
        _paySource = 1;
    }else if([_payway isEqualToString:UPPAYID] ){
        _anquPayText.text = @"银联支付";
        _paySource = 2;
    }else if([_payway isEqualToString:WEIXINPAYID] ){
        _anquPayText.text = @"微信支付";
        _paySource = 7;
    }
    _anquPayText.font = [UIFont systemFontOfSize:14.0];
    _anquPayText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_anquPayText];
        
    _custom = [[UIButton alloc] init];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(plugPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理关闭
    [self.view addSubview:_custom];
        
    _anquSplitLine = [[UIImageView alloc] init];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
   
    
    _anquPayWayText = [[UILabel alloc] init];
    _anquPayWayText.text = @"您选择的支付方式:";
    _anquPayWayText.font = [UIFont systemFontOfSize:15.0];
    _anquPayWayText.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_anquPayWayText];
    _anquPayValue = [[UILabel alloc] init];
    _anquPayValue.text = _anquPayText.text;
    _anquPayValue.font = [UIFont systemFontOfSize:16.0];
    _anquPayValue.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquPayValue];
    
    _anquCashValue = [[UILabel alloc] init];
    _anquCashValue.text = [@"支付金额:   " stringByAppendingFormat:@"%@",[OrderInfo sharedSingleton].money];
    _anquCashValue.font = [UIFont systemFontOfSize:15.0];
    _anquCashValue.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_anquCashValue];
    
    _anquGoodName = [[UILabel alloc] init];
    if([OrderInfo sharedSingleton].subject ==nil){
        _anquRoleName.text = @"商品名称:   游戏内商品" ;
    }else{
        _anquGoodName.text = [@"商品名称:   " stringByAppendingFormat:@"%@",[OrderInfo sharedSingleton].subject];
    }
    _anquGoodName.font = [UIFont systemFontOfSize:15.0];
    _anquGoodName.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_anquGoodName];
    
    _anquRoleName = [[UILabel alloc] init];
    if([OrderInfo sharedSingleton].roleName == nil){
        _anquRoleName.text = @"  ";
    }else{
        _anquRoleName.text = [@"角色名:     " stringByAppendingFormat:@"%@",[OrderInfo sharedSingleton].roleName];
    }
    _anquRoleName.font = [UIFont systemFontOfSize:15.0];
    _anquRoleName.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_anquRoleName];
    
    if ([_deviceName isEqualToString:@"iPod touch"]) {
        _anquPayWayText.hidden = YES;
        _anquPayValue.hidden = YES;
        _anquGoodName.hidden = YES;
    }

    _anquTipLabel = [[UILabel alloc] init];
    _anquTipLabel.textColor = UIColorFromRGB(0xff6600);
    _anquTipLabel.text = @"注:请您确认无误后支付";
    _anquTipLabel.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:_anquTipLabel];
    
    _anquCommit = [[UIButton alloc] init];
    [_anquCommit setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquCommit setTitle:@"确定" forState:UIControlStateNormal];
    _anquCommit.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_anquCommit addTarget:self action:@selector(anquCommitClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_anquCommit];
}

-(void)initPayValuePortrait
{
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
    
    [_back setFrame:CGRectMake(5, 5, 50, 50)];

    [_anquPayText setFrame:CGRectMake(min/2 - 40, 3, 80, 60)];
    
    [_custom setFrame:CGRectMake(min - 55, 5, 50, 60)];
    
    [_anquSplitLine setFrame:CGRectMake(0, 55, min, 1)];
    
    [_anquPayWayText setFrame:CGRectMake(5, 90, 140, 60)];
    
    [_anquPayValue setFrame:CGRectMake(145, 90, 80, 60)];

    if (_orientation == UIInterfaceOrientationUnknown) {
       _anquRoleName.hidden = YES;
        
      [_anquCashValue setFrame:CGRectMake(5, 140, 200, 60)];
        
       [_anquGoodName setFrame:CGRectMake(5,180, 200, 60)];
        
        [_anquTipLabel setFrame:CGRectMake(15, min-90, min - 30, 40)];
        
        [_anquCommit setFrame:CGRectMake(15, min-50, min - 30, 40)];
        
    }else{
         [_anquCashValue setFrame:CGRectMake(5, 160, 200, 60)];
        
        [_anquRoleName setFrame:CGRectMake(5,330,200,60)];
        
        [_anquGoodName setFrame:CGRectMake(5,max-230, 200, 60)];
        
        [_anquTipLabel setFrame:CGRectMake(15, max-100, max - 30, 40)];
        
        [_anquCommit setFrame:CGRectMake(15, max-50, min - 30, 40)];
    }
    
    
}

//横屏
#pragma mark -Land
-(void)initPayValueLand
{
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
    
    [_back setFrame:CGRectMake(5, 2, 50, 50)];
    
    [_anquPayText setFrame:CGRectMake(max/2 - 40, 2, 80, 50)];
    
    [_custom setFrame:CGRectMake(max - 55, 2, 50, 50)];
    
    [_anquSplitLine setFrame:CGRectMake(0, 40, max, 1)];

    [_anquPayWayText setFrame:CGRectMake(15, 50, 140, 50)];

    [_anquPayValue setFrame:CGRectMake(155, 50, 140, 50)];
    
    [_anquCashValue setFrame:CGRectMake(15, 80, 200, 50)];
    
    [_anquGoodName setFrame:CGRectMake(15, 100, 200, 50)];
    
    [_anquRoleName setFrame:CGRectMake(15, 120, 200, 50)];
    
    [_anquTipLabel setFrame:CGRectMake(15, min-90, max - 30, 40)];
    
  //  [_anquCashTextField setFrame:CGRectMake(15, 200, SCREENWIDTH - 30, 35)];
    //交换
  //  [_anquExchangeBt setFrame:CGRectMake(15, 240, SCREENWIDTH - 30, 35)];
    
    [_anquCommit setFrame:CGRectMake(15, min-55, max - 30, 45)];
}

#pragma mark -PoritButton
-(void)initWithButton
{
    int count = 1;
    
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
                button.frame = CGRectMake(100*j - 85, 160, 90, 45);
            }
            else if(i == 2)//2
            {
                button.frame = CGRectMake(100*j - 85, 215, 90, 45);
            }
            else//3
            {
                button.frame = CGRectMake(100*j - 85, 270, 90, 45);
            }
            
            [self.view addSubview:button];
        }
    }

}

#pragma mark -LandButton
-(void)initWithLandButton
{
    int count = 1;
    
    for (int i = 1; i < 3; i++)
    {
        for (int j = 1; j < 6; j++) {
            if (count > 8) {
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
                button.frame = CGRectMake(90*j - 75, 90, 80, 35);
            }
            else//2行
            {
                button.frame = CGRectMake(90*j - 75, 135, 80, 35);
            }
            
            [self.view addSubview:button];
        }
    }
}

//back
-(void)plugPayBackClick
{
    if([OrderInfo sharedSingleton].paystatus!=AnquPayResultCodeSucceed || [OrderInfo sharedSingleton].paystatus != AnquPayResultCodeFail){
        [OrderInfo sharedSingleton].paystatus=AnquPayResultCodeCancel;
        NSLog(@"支付取消");
        
        [_delegate AnquPayResult:AnquPayResultCodeCancel];
    }
    [self dismissViewControllerAnimated:NO completion:nil];//支付取消callback
}

//提交按钮
-(void)anquCommitClick:(id)sender
{
    
    _aliPost = [[httpRequest alloc] init];
    _aliPost.dlegate = self;
    
    //设置loading
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.dimBackground = YES;
    _HUD.labelText = @"请求安全支付中...";
    [OrderInfo sharedSingleton].HUD =_HUD;
    //[_HUD show: YES];
    
    if([_payway isEqualToString:ALIPAYID] ){
        [[AnquInterfaceKit sharedInstance] anquRequestedpay:ALIPAYID hubView:_HUD];//初始支付请求

        
    }else if([_payway isEqualToString:UPPAYID] ){
      //  [[AnquInterfaceKit sharedInstance] anquRequestedpay:UPPAYID hubView:_HUD];//初始支付请求
        
        [self Requestcreditpay:UPPAYID hubView:_HUD];
        
    }else if([_payway isEqualToString:WEIXINPAYID] ){
      //  [[AnquInterfaceKit sharedInstance] anquRequestedpay:WEIXINPAYID hubView:_HUD];//初始支付请求
        
           [self Requestcreditpay:WEIXINPAYID hubView:_HUD];
        
    }

//    UIApplication *app = [UIApplication sharedApplication];
//    NSURL *url = [NSURL URLWithString:@"alipay://alipay"];
//    if ([app canOpenURL:url] &&  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
   
//  sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID, [OrderInfo sharedSingleton].serverName ,[ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].channelID, partner, [AnquUser sharedSingleton].uid, _money, _strPayWay, mTime, [AppInfo sharedSingleton].gameKey];
}

-(void)unioncallback:(NSString*)tempResult
{
    [[OrderInfo sharedSingleton].HUD hide:YES];
    NSDictionary *FirstResult = [tempResult JSONValue];
    NSString *sign = [FirstResult objectForKey:@"sign"];
    
    DDLogDebug(@"------进入银联支付---，sign=%@-",sign);
    
//    NSRange coderange = [sign rangeOfString:@"respCode="];
//    NSRange tnrange = [sign rangeOfString:@"&tn="]; //获取responseCode位置
//    NSRange methodrange = [sign rangeOfString:@"&respMsg"];
//    
//    NSRange rangeForcode = NSMakeRange(coderange.location+coderange.length,tnrange.location-coderange.length);
//    NSString *responseCode = [sign substringWithRange:rangeForcode]; //截取字符串responseCode
//    
//    NSRange rangeForTn = NSMakeRange(tnrange.location+tnrange.length,methodrange.location-methodrange.length-+tnrange.length);
//    [OrderInfo sharedSingleton].transNum = [sign substringWithRange:rangeForTn];
    
    [OrderInfo sharedSingleton].transNum = sign;
   // NSString *tngot = [sign substringWithRange:rangeForTn];
  //  NSString *tn = [PayCreditCard trim:tngot];
    NSString *tn = [PayCreditCard trim:sign];

    
    DDLogDebug(@"银联tn is %@",[OrderInfo sharedSingleton].transNum);
    [_HUD hide:YES];
    [UPPayPlugin startPay:tn mode:@"00" viewController:self delegate:self];//银联支付
       
       // [self unin_callback:[OrderInfo sharedSingleton].transNum];
    
    
}

+(NSString *)trim:(NSString*)str{
    if (str && str.length>0) {
        while ([str hasPrefix:@" "]) {
            str=[str substringFromIndex:1];
        }
        while ([str hasSuffix:@" "]) {
            str=[str substringToIndex:str.length-1];
        }
        return str;
    }
    return @"";
}


-(void)unin_callback:(NSString*)tn
{
    [_HUD hide:YES];
    [UPPayPlugin startPay:tn mode:@"00" viewController:self delegate:self];//银联支付

}

+ (NSString*)urlEncodedString:(NSString *)string
{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}


-(void)Requestcreditpay:(NSString *)paychannel hubView:(MBProgressHUD *)hub
{
    if (hub != NULL) {
        [hub show: YES];
    }
    
    NSString *firstsign = @"";
    NSString *finalsign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    //  NSString *payWay = @"";
    NSString *deviceNo = [ActivateInfo sharedSingleton].deviceno;
    NSString *gameID = [AppInfo sharedSingleton].gameID;
    NSString *channelID = [AppInfo sharedSingleton].channelID;
    [OrderInfo sharedSingleton].channelId = channelID;
    NSString *gameKey = [AppInfo sharedSingleton].gameKey;
    NSString *uid = [AnquUser sharedSingleton].uid;
    [OrderInfo sharedSingleton].uid = uid;
    NSString *money = [OrderInfo sharedSingleton].money;
    //NSString *acount = [AnquUser sharedSingleton].username;
    NSString *paytype = [OrderInfo sharedSingleton].type;  //支付渠道，今后定义为枚举
    NSString *appid = [AppInfo sharedSingleton].gameID;
    [OrderInfo sharedSingleton].cpappid = appid;
    //第二版本增加区服充值统计
    //    NSString *serverName = [OrderInfo sharedSingleton].serverName;
    //    NSString *roleName = [OrderInfo sharedSingleton].roleName;
    //    NSString *roleId = [OrderInfo sharedSingleton].roleId;
    //    NSString *serverId = [OrderInfo sharedSingleton].serverId;
    
    NSString *outOrderId = [OrderInfo sharedSingleton].outOrderid;
    //NSString *pext = [OrderInfo sharedSingleton].pext; //附加信息
    
    if ([channelID length] == 0) {
        [UserData showMessage:@"渠道号不能为空"];
        return;
    }
    
    if ([deviceNo length] == 0) {
        [UserData showMessage:@"设备号获取异常"];
        return;
    }
    
    if ([uid length] == 0) {
        [UserData showMessage:@"用户id不能为空"];
        return;
    }

    
    if ([[OrderInfo sharedSingleton].type length] == 0) {
        [UserData showMessage:@"支付渠道不能为空"];
        return;
    }
    
    firstsign = [firstsign stringByAppendingFormat:@"%@%@%@%@%@%@", paytype, outOrderId,uid, money, gameID, [OrderInfo sharedSingleton].orderAnquInnerDescription];
    DDLogDebug(@"PayCrCard 支付初始请求提交时的sign = %@", firstsign);
    
 //   DDLogDebug(@"PayCrCard-Md5 第一次sign = %@", [MyMD5 md5:firstsign]);
    
    finalsign = [finalsign stringByAppendingFormat:@"%@%@",[MyMD5 md5:firstsign],gameKey];
  //  DDLogDebug(@"PayCrCard-Md5 第二次sign = %@", [MyMD5 md5:finalsign]);
    
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:gameID, @"cpappid",paychannel,@"channel",
                                // deviceNo, @"deviceno",
                                // serverName, @"serverName",//游戏服名
                                //  roleName, @"roleName",//充值角色
                                // roleId, @"roleId",//充值角色id
                                // serverId, @"serverId",//游戏服名id
                                //  payWay, @"payway",//充值方式0 非定额 1 定额
                                //@"1",@"debug",
                                //  pext, @"pext"
                                channelID,@"gchannel",
                                uid, @"uid",
                                money, @"amt",
                                [MyMD5 md5:finalsign], @"sign",
                                outOrderId ,@"cporder",
                                @"1",@"fromos",   //ios标志位
                                [OrderInfo sharedSingleton].orderAnquInnerDescription, @"rsadata",nil];
    
    NSString *postData = [dictionary buildQueryString];
    
    DDLogDebug(@"PayCrCard-支付请求提交postData = %@", postData);
    
    NSString *var = [ANQUINITIALPAY_URL stringByAppendingFormat:@"%@%@", @"?", postData];
    //DDLogDebug(@"PayCrCard-支付请求提交pay = %@", var);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(pay_crcallback:);
    _request.error = @selector(pay_error:);
    [_request post:ANQUINITIALPAY_URL argData:postData];
}

-(void)pay_crcallback:(NSString*)result
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSString *totested = @"{\"status\":\"0\",\"order\":\"332590000009410\",\"channel\":\"10002\",\"sign\":\"201508151018363384498\",\"ordertime\":\"20150815101836\"}";
    NSString *toparse = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSError * error = nil;
  //   NSMutableDictionary *rootDic = [parser objectWithString:toparse error:&error];
    
    NSDictionary *rootDic = [parser objectWithString:toparse];
    
    NSString *codeNum = [rootDic objectForKey:@"status"];
     DDLogDebug(@"PayCrCard-支付 toparsed=%@",rootDic);

    if (error!=nil) {
        DDLogDebug(@"PayCrCard-支付异常 error = %@", error);
      [UserData showMessage:@"支付失败，请重试"];
      [_delegate AnquPayResult:AnquPayResultCodeFail];  //购买支付失败
      return;
    }
       
    NSMutableString *outSign = nil;
    if ([codeNum intValue] == 0)
    {
        NSString *orderid = [rootDic objectForKey:@"order"];
        NSString *payChannel = [rootDic objectForKey:@"channel"];
        NSString * orderTime= [rootDic objectForKey:@"ordertime"];
        
        [OrderInfo sharedSingleton].anquOrderid = orderid;
        [OrderInfo sharedSingleton].ordertime = orderTime;
        
        if([payChannel isEqualToString:UPPAYID]){
            outSign = [rootDic objectForKey:@"sign"]; //用安趣的orderid的签名
            DDLogDebug(@"进入银联支付，outSign=%@",outSign);
            [self unioncallback:result];
        }
        if([payChannel isEqualToString:WEIXINPAYID]){
             DDLogDebug(@"paycreditcard 进入微信支付，");
            [self weixinpay:result];
        }

        
    }else{
        NSString *errorCode = [rootDic objectForKey:@"errcode"];
        DDLogDebug(@"errcode is %@",errorCode);
        [_delegate AnquPayResult:AnquPayResultCodeFail];  //购买支付失败
        
         [[OrderInfo sharedSingleton].HUD hide: YES];
        
        __weak typeof(self) weakSelf = self;
        
        __block UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[PayCreditCard getErrormsg:errorCode] preferredStyle:(UIAlertControllerStyleAlert)];
         UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        [alert addAction:confirm];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:alert animated:YES completion:nil];
        });
     //   sleep(3);
     // [UserData showMessage:[PayCreditCard getErrormsg:errorCode]];

       //  [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)pay_error:(MBProgressHUD*)hub
{
    if (hub != NULL) {
        [hub hide:YES];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

//银联支付callback
- (void)UPPayPluginResult:(NSString *)result
{
    DDLogDebug(@"unicom callback = %@", result);
    
    [UserData updateOrderInfo];
    [[OrderInfo sharedSingleton] setPayname:@"银联"];
    
    if ([result isEqualToString:@"success"]) {
        [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeSucceed;
        [UserData showMessage:paysuccessTip];
        //银联支付成功 callback给 CP
        [_delegate AnquPayResult:AnquPayResultCodeSucceed];  //购买支付成功
         [self dismissViewControllerAnimated:YES completion:nil];

    }
    else if([result isEqualToString:@"fail"])
    {
        [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeFail;
        [UserData showMessage:[NSString stringWithFormat:@"本次支付失败.%@",payreturnTip]];
        DDLogDebug(@"银联支付失败");
        //银联支付失败 callback给 CP
        [_delegate AnquPayResult:AnquPayResultCodeFail];  //购买支付失败
         [self dismissViewControllerAnimated:YES completion:nil];

    }else if([result isEqualToString:@"cancel"])
    {
        [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeCancel;
        [UserData showMessage:[NSString stringWithFormat:@"您取消了本次支付.%@",payreturnTip]];
        //银联支付取消 callback给 CP
        [_delegate AnquPayResult:AnquPayResultCodeCancel];  //购买支付取消
         [self dismissViewControllerAnimated:YES completion:nil];

    }
    [self showAlertMessage:result];
}

-(void)weixinpay:(NSString*)tempResult{
    IPNPreSignMessageUtil *preSign=[[IPNPreSignMessageUtil alloc]init];
    preSign.appId=@"1434524859789067";
    preSign.mhtOrderNo=[[OrderInfo sharedSingleton] anquOrderid];
    preSign.mhtOrderName=[[OrderInfo sharedSingleton] subject];
    preSign.mhtOrderType=@"01";
    preSign.mhtCurrencyType=@"156";
    
    int moneyFloat = [[[OrderInfo sharedSingleton] money] floatValue] *100;
    NSString* sendMoney = [NSString stringWithFormat:@"%d",moneyFloat ];
    preSign.mhtOrderAmt=sendMoney;
    
    preSign.mhtOrderDetail=[[OrderInfo sharedSingleton] body];
    preSign.mhtOrderStartTime=[[OrderInfo sharedSingleton] ordertime];
    preSign.notifyUrl=API_URL_WEIXINNOTIFY;
    preSign.mhtCharset=@"UTF-8";
    preSign.mhtOrderTimeOut=@"3600";
    preSign.payChannelType=@"13";
    
    
    NSString *originStr=[preSign generatePresignMessage];
    
    
    _presignStr= originStr;
    DDLogDebug(@"paycreditcard 微信支付1，originStr=%@,mhtOrderAmt=%@,mhtOrderNo=%@,mhtOrderName=%@,mhtOrderDetail=%@,mhtOrderStartTime=%@",originStr,
               preSign.mhtOrderAmt,preSign.mhtOrderNo,preSign.mhtOrderName,preSign.mhtOrderDetail,preSign.mhtOrderStartTime);
    
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)originStr,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    
    
    NSString *presignStr=@"paydata=";
    presignStr=[presignStr stringByAppendingString:outputStr];
    //NSString* postData=[presignStr dataUsingEncoding:NSUTF8StringEncoding];
    
    DDLogDebug(@"paycreditcard 微信支付，_presignStr=%@,outputstr=%@",_presignStr,outputStr);

    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(weixin_callback:);
    _request.error = @selector(pay_error:);
    [_request post:API_URL_GETWEIXIN argData:presignStr];
    
    //    NSURL* url = [NSURL URLWithString:API_URL_GETWEIXIN];
    //    NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
    //    [urlRequest setHTTPMethod:@"POST"];
    //    urlRequest.HTTPBody=[presignStr dataUsingEncoding:NSUTF8StringEncoding];
    //    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    //    [urlConn start];
    [self showAlertWait];
}

- (void)showAlertWait {
    mAlert = [[UIAlertView alloc] initWithTitle:@"正在获取订单,请稍候..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [mAlert show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [mAlert addSubview:aiv];
}

-(void)weixin_callback:(NSData*)result
{
    [self hideAlert];
    NSString* data = [[NSMutableString alloc] initWithString:result];
    NSString* payData=[_presignStr stringByAppendingString:@"&"];
    payData=[payData stringByAppendingString:data];
    
    DDLogDebug(@"微信支付请求 result = %@, payData final=%@", result,payData);

    [IpaynowPluginApi pay:payData AndScheme:@"AnquIOSWeixinsdk" viewController:self delegate:self];
    
    // [_delegate AnquPayResult:AnquPayResultCodeFail];
    
    sleep(3);
    [[OrderInfo sharedSingleton].HUD hide: YES];
    
}
- (void)hideAlert {
    if (mAlert != nil)
    {
        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
        mAlert = nil;
    }
}
-(void)IpaynowPluginResult:(IPNPayResult)result errInfo:(NSString *)errInfo{
    NSString *resultString=nil;
    [UserData updateOrderInfo];
    
     [[OrderInfo sharedSingleton] setPayname:@"微信支付"];
    
    switch (result) {
        case IPNPayResultSuccess:
            resultString=@"支付成功";
            [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeSucceed;
            
            [_delegate AnquPayResult:AnquPayResultCodeSucceed];
            break;
        case IPNPayResultCancel:
            resultString=@"支付被取消";
            [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeCancel;
            
            [_delegate AnquPayResult:AnquPayResultCodeCancel];
              break;
        case IPNPayResultFail:
            resultString=[NSString stringWithFormat:@"支付失败:%@",errInfo];
            [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeFail;
             [_delegate AnquPayResult:AnquPayResultCodeFail];
            break;
        case IPNPayResultUnknown:
            resultString=[NSString stringWithFormat:@"支付结果未知:%@",errInfo];
            [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeFail;
             [_delegate AnquPayResult:AnquPayResultCodeFail];
             break;
            
        default:
            break;
    }
    
    __block UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:resultString delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    dispatch_async(dispatch_get_main_queue(), ^{
         [self dismissViewControllerAnimated:YES completion:nil];
         //[self.parentViewController dismissViewControllerAnimated:YES completion:nil];
        [alert show];
    });
    
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:resultString
//                                                   delegate:nil
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
  
}


+(NSString *) getErrormsg:(NSString*)errorcode{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"提交的支付信息有误，请重新下单或联系客服。", @"001",
                                @"接入的渠道号有误，请联系客服。", @"002",
                                @"该游戏ID配置有误，请联系客服。",@"003",
                                @"该用户不存在。", @"004",
                                 @"支付验证sign错误。", @"005",
                                 @"支付入库操作有误，请联系客服。", @"006",
                                 @"该笔订单已经提交，如未支付成功，请您退出支付中心重新下单支付。", @"007",
                                @"服务器处理订单有误，请稍后重试。", @"999",nil];
    return [dictionary objectForKey:errorcode];
}


//-(void)alipayKuai_callback:(NSString *)tempResult{
//
//
//    if ([isSuccess intValue] != 24) {
//        NSString *body = [aliFirstResult objectForKey:@"msg"];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:body delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//}

- (void)showAlertMessage:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
    if ([textField.text length] != 0) {
        [_FlastSelectbutton setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
        _money = _FlastSelectbutton.titleLabel.text;
    }
    else
    {
        _money = textField.text;
    }
    
    self.view.frame =CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
}

//触摸view隐藏键盘——touchDown

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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

//-(void)selectCashButton:(id)sender
//{
//    if (_FlastSelectbutton) {//是否最后一次选中
//        [_FlastSelectbutton setBackgroundImage:[GetImage getSmallRectImage:@"anqu_cash_bg"] forState:UIControlStateNormal];
//    }
//    UIButton *AButton=sender;
//    [AButton setBackgroundImage:[GetImage getPayRectImage:@"anqu_pay_choose"] forState:UIControlStateNormal];
//    [AButton setContentMode:UIViewContentModeScaleAspectFill];
//    _FlastSelectbutton=AButton;
//
////    int mRatio = [CoinRatio sharedSingleton].ratio;
////    NSLog(@"mRatio = %d", mRatio);
////    NSString *btValue = [_cashArray objectAtIndex:_FlastSelectbutton.tag - 1];
////    NSString *cashValue = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@元可以兑换%d元宝", btValue, [btValue intValue]*mRatio]];
////    [_anquExchangeBt setTitle:cashValue forState:UIControlStateNormal];
//
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
