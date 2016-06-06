

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "AnquInterfaceKit.h"
#import "AppInfo.h"
#import "Activate.h"
#import "Login.h"
#import "PayHome.h"
//#import "QutoPayHome.h"
#import "OrderInfo.h"
#import "AcountHome.h"
#import "AcountWeb.h"
#import "SvUDIDTools.h"
#import "PlayerExtInfo.h"
#import "NSString+SBJSON.h"
#import "NSDictionary+QueryBuilder.h"
#import "IpaynowPluginApi.h"
#import "Kefuconnect.h"
#import "AnalysisInfo.h"
#import "AESCrypt.h"

@implementation AnquInterfaceKit

__strong static AnquInterfaceKit *singleton = nil;
__strong static DDTTYLogger *logger;

static UIInterfaceOrientation appOrientation;

static  int ddLogLevel = LOG_FLAG_ERROR | LOG_FLAG_INFO;


/**
 *  API单例
 *
 *  @return 返回单例
 */
+(AnquInterfaceKit*)sharedInstance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        //singleton = [[self alloc] init];
        singleton = [[super allocWithZone:NULL] init];
    });
    
    [self setLogger]; //后面移到框架外调用代码处  设置开关
    
    return singleton;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+(void)setLogger{
    //创建一个终端显示日志
   logger = [DDTTYLogger sharedInstance]; //只需要初始化一次
    //1.1将日志往终端上输出
    [DDLog addLogger:logger];
 
}

+(void)setDebugLogOn:(BOOL)debug{
    if (debug == TRUE) {
        ddLogLevel = LOG_FLAG_DEBUG;
    }
}


+(int)getLoggerLevel{
    // int ddLogLevel = LOG_FLAG_ERROR | LOG_FLAG_INFO;
    return ddLogLevel;
}
/**
 *  设置委托
 *
 *  @param argDelegate 委托
 */
-(void)setDelegate:(id<AnquCallback>)argDelegate
{
    _delegate = argDelegate;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unionPayResult:) name:@"ANQUUPPayResultNotification" object: nil];
}

-(void)setPaypluginaway
{
    [IpaynowPluginApi willEnterForeground];
}

/**
 *  CP商渠道号，游戏ID，游戏ID，渠道号从Anqu后台获取
 *
 *  @param AppId       游戏ID
 *  @param argChannelId 渠道ID
 *  @param argGameKey 游戏key
 *  @param partnerID CP的ID
 *  @param partnerKey CP的鉴别码
 */
-(void) setApp:(NSString*)AppId GameKey:(NSString*)argappKey ChannelID:(NSString*)argChannelId
     PartnerID:(NSString*)partnerID PartnerKey:(NSString*)partnerKey
{
    [AppInfo sharedSingleton].gameID = AppId;
    [AppInfo sharedSingleton].gameKey = argappKey;
    [AppInfo sharedSingleton].channelID = argChannelId;
    [AppInfo sharedSingleton].partnerID = partnerID;
    [AppInfo sharedSingleton].partnerKey = partnerKey;
}


/**
 *  激活接口
 */
-(void)activate
{
    Activate *active = [[Activate alloc] init];
    active.delegate = _delegate;//设置委托
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    //[UIApplication sharedApplication].delegate.window.rootViewController;
    [active activiateToAnqu:rootViewController];

    [self getAnalysisInfo];
}


+(void)setOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    appOrientation = toInterfaceOrientation;
}
+(UIInterfaceOrientation)getOrientation
{
    return appOrientation;
}

/**
 *  登录接口
 */
-(void)anquLogin
{
    if ([ActivateInfo sharedSingleton].deviceno == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请先激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    Login *login = [[Login alloc] init];
    login.delegate = _delegate;
    
//    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController* rootViewController=[UIApplication sharedApplication].keyWindow.rootViewController;
    
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [rootViewController presentViewController:login animated:YES completion:^{
        NSLog(@"进入登录");
    }];
    
}

/**
 *  登录接口,隐藏悬浮球
 */
-(void)anquLogin:(BOOL)isshowDraggle;
{
    if ([ActivateInfo sharedSingleton].deviceno == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请先激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    Login *login = [[Login alloc] init];
    login.delegate = _delegate;
    login.isshowDraggle = isshowDraggle;
    
    UIViewController* rootViewController=[UIApplication sharedApplication].keyWindow.rootViewController;
    
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    //[rootViewController presentModalViewController:login animated:NO];
    
    [rootViewController presentViewController:login animated:YES completion:^{
        NSLog(@"进入登录");
    }];
    
}

/**
 *  直登接口
 */
-(void)anquDirectLogin
{
    if ([ActivateInfo sharedSingleton].deviceno == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请先激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self anquLoginDirect];
}

/**
 *  初始化玩家信息
 *
 *  @param serverid    区服id
 *  @param serverName  区服名字
 *  @param roleld      游戏ID
 *  @param roleName    游戏名字
 *  @param mOutOrderid 外部订单号
 *  @param mPext       附加信息
 */
-(void)setPlayerInfo:(NSString*)serverid serverName:(NSString*)serverName RoleId:(NSString*)roleld RoleName:(NSString*)roleName RoleLevel:(NSString*)roleLevel
{
    [OrderInfo sharedSingleton].serverId = serverid;
    [OrderInfo sharedSingleton].serverName = serverName;
    [OrderInfo sharedSingleton].roleId = roleld;
    [OrderInfo sharedSingleton].roleName = roleName;
    [OrderInfo sharedSingleton].roleLevel = roleLevel;
    //    [OrderInfo sharedSingleton].outOrderid = mOutOrderid;
    //    [OrderInfo sharedSingleton].pext = mPext;
    PlayerExtInfo *extSubmit = [[PlayerExtInfo alloc] init];
    extSubmit.delegate = _delegate;
    [extSubmit submitExtInfo];
}

//个人中心
-(void)anquAcountManage
{
    AcountHome *acount = [[AcountHome alloc] init];
    acount.delegate = _delegate;
    UIViewController* rootViewController=[UIApplication sharedApplication].keyWindow.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [rootViewController presentModalViewController:acount animated:YES ];
}

//订单支付项目设置
-(void)anquPay:(NSString*)money Subject:(NSString*)subject OutOrderId:(NSString*)mOutOrderid Body:(NSString*)body Pext:(NSString*)mPext
{
    if ([ActivateInfo sharedSingleton].deviceno == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请先激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [OrderInfo sharedSingleton].outOrderid = mOutOrderid;
    [OrderInfo sharedSingleton].subject = subject;
    [OrderInfo sharedSingleton].body = body;
    [OrderInfo sharedSingleton].pext = mPext;
    [OrderInfo sharedSingleton].money = money;
  
   // DDLogInfo(@"info %@",@"hello");
    DDLogDebug(@"moneyllllllllll=%@",[OrderInfo sharedSingleton].money);

    PayHome *pay = [[PayHome alloc] init];
    pay.delegate = _delegate;
    UIViewController* rootViewController=[UIApplication sharedApplication].keyWindow.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [rootViewController presentViewController:pay animated:YES completion:^{
        NSLog(@"进入支付");
    }];
   // [rootViewController presentModalViewController:pay animated:YES ];
    
}

-(void)anquRequestedpay:(NSString *)paychannel hubView:(MBProgressHUD *)hub
{
    if (hub != NULL) {
    [hub show: YES];
    }
    // 登录请求
    //    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    //    NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
    
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
    
    if ([mTime length] == 0) {
        [UserData showMessage:@"时间戳不能为空"];
        return;
    }
    
    if ([[OrderInfo sharedSingleton].type length] == 0) {
        [UserData showMessage:@"支付渠道不能为空"];
        return;
    }
    
    firstsign = [firstsign stringByAppendingFormat:@"%@%@%@%@%@%@", paytype, outOrderId,uid, money, gameID, [OrderInfo sharedSingleton].orderAnquInnerDescription];
    DDLogDebug(@"支付初始请求提交时的sign = %@", firstsign);
    
    DDLogDebug(@"Md5 第一次sign = %@", [MyMD5 md5:firstsign]);
    
    finalsign = [finalsign stringByAppendingFormat:@"%@%@",[MyMD5 md5:firstsign],gameKey];
    DDLogDebug(@"Md5 第二次sign = %@", [MyMD5 md5:finalsign]);
    
    //partner
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
    
    DDLogDebug(@"支付请求提交postData = %@", postData);
    
    NSString *var = [ANQUINITIALPAY_URL stringByAppendingFormat:@"%@%@", @"?", postData];
    DDLogDebug(@"支付请求提交pay = %@", var);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(pay_callback:);
    _request.error = @selector(pay_error:);
    [_request post:ANQUINITIALPAY_URL argData:postData];
}

-(void)pay_callback:(NSString*)result
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *codeNum = [rootDic objectForKey:@"status"];
    DDLogDebug(@"初次支付请求 interfaceKit result = %@,status=%@", result,codeNum);
    
    NSMutableString *outSign = nil;
    if ([codeNum intValue] == 0)
    {
        NSString *orderid = [rootDic objectForKey:@"order"];
        NSString *payChannel = [rootDic objectForKey:@"channel"];
        NSString *ordertime = [rootDic objectForKey:@"ordertime"];
        
        [OrderInfo sharedSingleton].anquOrderid = orderid;
        [OrderInfo sharedSingleton].ordertime = ordertime;
        
        if([payChannel isEqualToString:ALIPAYID]||[payChannel isEqualToString:UPPAYID]){
            outSign = [rootDic objectForKey:@"sign"]; //用安趣的orderid的签名
        }
        //[OrderInfo sharedSingleton].orderDescription 对应于innersign,extInfo就是设置这个值
        if([payChannel isEqualToString:ALIPAYID]){
            NSString *alipayDescription = [[OrderInfo sharedSingleton].orderAnquInnerDescription stringByReplacingOccurrencesOfString:[OrderInfo sharedSingleton].outOrderid  withString:orderid];//专供alipay使用
            
            [OrderInfo sharedSingleton].alipayDesc = alipayDescription;
             DDLogDebug(@"ali替换后字符串为%@", alipayDescription);
            [self alipay:alipayDescription Sign:outSign];
            
        }
        if([payChannel isEqualToString:UPPAYID]){
              DDLogDebug(@"AnquInterfaceKit进入银联支付");
            
            [self union_callback:result];
            
        }
        if([payChannel isEqualToString:SZFPAYID]){
            DDLogDebug(@"AnquInterfaceKit进入神州付支付");
            [PayOneCard paywithSZF:[OrderInfo sharedSingleton].HUD];
        }
        if([payChannel isEqualToString:JUNWANGPAYID]){
            DDLogDebug(@"AnquInterfaceKit进入骏网卡支付");
            [PayOneCard paywithJWK:[OrderInfo sharedSingleton].HUD];
        
        }
//        if([payChannel isEqualToString:WEIXINPAYID]){
//            DDLogDebug(@"AnquInterfaceKit进入微信支付");
//            [self weixinpay:result];
//        }
        
    }else{
         NSString *errorCode = [rootDic objectForKey:@"errcode"];
         DDLogDebug(@"errcode is %@",errorCode);
        [UserData showMessage:[PayCreditCard getErrormsg:errorCode]];
        
        [_delegate AnquPayResult:AnquPayResultCodeFail];
        
        sleep(3);
         [[OrderInfo sharedSingleton].HUD hide: YES];
    }
}

-(void)pay_error:(MBProgressHUD*)hub
{
    if (hub != NULL) {
        [hub hide:YES];
    }
    
    [_delegate AnquPayResult:AnquPayResultCodeFail];
    [UserData showMessage:@"网络连接超时"];
  }

-(void)union_callback:(NSString*)tempResult
{
    [[OrderInfo sharedSingleton].HUD hide:YES];
    NSDictionary *FirstResult = [tempResult JSONValue];
    NSString *sign = [FirstResult objectForKey:@"sign"];
 
    NSRange coderange = [sign rangeOfString:@"respCode="];
    NSRange tnrange = [sign rangeOfString:@"&tn="]; //获取responseCode位置
    NSRange methodrange = [sign rangeOfString:@"&signMethod"];
    
    NSRange rangeForcode = NSMakeRange(coderange.location+coderange.length,tnrange.location-coderange.length);
    NSString *responseCode = [sign substringWithRange:rangeForcode]; //截取字符串responseCode
    
    NSRange rangeForTn = NSMakeRange(tnrange.location+tnrange.length,methodrange.location-methodrange.length-+tnrange.length);
    [OrderInfo sharedSingleton].transNum = [sign substringWithRange:rangeForTn];
    
    DDLogDebug(@"银联responseCode is %@，tn=%@",responseCode,[OrderInfo sharedSingleton].transNum);
    if ([responseCode isEqualToString:@"00"]) {
         DDLogDebug(@"------进入银联支付Anquinterface----");
    
        [[[PayCreditCard alloc] init] unin_callback:[OrderInfo sharedSingleton].transNum];
        
      // [UPPayPlugin startPay:[OrderInfo sharedSingleton].transNum  mode:@"00" viewController:[[PayCreditCard alloc] init] delegate:self];//银联支付
    }

    }


//支付宝
-(void)alipay:(NSString *)orderSpec Sign:(NSString *)aliSign{
    NSString *appScheme = @"alisdkpay";
   
    NSString *signedString = [PayCreditCard urlEncodedString:aliSign];

    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderSpec, signedString, @"RSA"];
    DDLogDebug(@"支付宝请求：%@",orderString);
    
    // __block NSString *paymessage = nil;
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        DDLogDebug(@"reslut = %@",resultDic);
        
        [[OrderInfo sharedSingleton].HUD  hide: YES];
        NSString *isSuccess = [resultDic objectForKey:@"resultStatus"];
        
        [UserData updateOrderInfo];
       [[OrderInfo sharedSingleton] setPayname:@"支付宝"];
       
        if ([isSuccess intValue] == 9000) {
            NSString *body = [resultDic objectForKey:@"memo"];
            [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeSucceed;
            [_delegate AnquPayResult:AnquPayResultCodeSucceed]; //支付成功
            [UserData showMessage:paysuccessTip];
            return;
            
        }else if([isSuccess intValue] == 6001) { //支付取消
            [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeCancel;
 
            [_delegate AnquPayResult:AnquPayResultCodeCancel];
            [UserData showMessage:[NSString stringWithFormat:@"您取消了本次支付.%@",payreturnTip]];
            
            DDLogInfo(@"支付取消");
            return;
            
        }else{ //支付失败
            NSString *body = [resultDic objectForKey:@"memo"];
      
            [UserData showMessage:[NSString stringWithFormat:@"您本次支付失败，原因是%@ %@",body,payreturnTip]];
            [OrderInfo sharedSingleton].paystatus = AnquPayResultCodeFail;

            [_delegate AnquPayResult:AnquPayResultCodeFail];
            return;
        }
        
    }];
    
    
//    __block UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:paymessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self  dismissViewControllerAnimated:YES completion:nil];
//    });
    [[OrderInfo sharedSingleton].HUD hide:YES afterDelay:5];//5秒后消失
    
}


////支付宝网页
//- (void)alixPayResult:(NSURL *)paramURL{
//    NSLog(@"alipay back %@", paramURL);
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"finish" object:@"0"];
//};

-(void)unionPayResult:(NSNotification *)noti
{
    [UserData updateOrderInfo];
    DDLogDebug(@"银联支付结果-------%@",noti.object);
    if ([noti.object isEqualToString:@"success"]) {
        [_delegate AnquPayResult:AnquPayResultCodeSucceed];
    }else if ([noti.object isEqualToString:@"fail"]){
        [_delegate AnquPayResult:AnquPayResultCodeFail];
    }else
    {
        [_delegate AnquPayResult:AnquPayResultCodeCancel];
    }
}

//支付页面显示
-(void)suspendView:(int)payway
{
    if (payway == 2)
    {
        AcountHome *acount = [[AcountHome alloc] init];
        acount.delegate = _delegate;
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [rootViewController presentModalViewController:acount animated:YES ];
    }else if(payway == 1){
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        Kefuconnect *kefu = [[Kefuconnect alloc] init];
        //manual.payway = (int)[indexPath row] ;
        [rootViewController presentModalViewController:kefu animated:YES];
        
       //  [UserData showMessage:@"客官，请联系客服邮箱:kefu@anqu.com."];
        return;
    }
        
//    else  //网页支付
//    {
//        AcountWeb *acount = [[AcountWeb alloc] init];
//        acount.payway = payway;
//        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
//        rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
//        [rootViewController presentModalViewController:acount animated:YES ];
//    }
}

-(void)anquLoginDirect
{
      UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow .rootViewController;
    
    _HUD = [[MBProgressHUD alloc] initWithView:rootViewController.view];
    [rootViewController.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走，玩命登陆中...";
    [_HUD show: YES];
    
    
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    sign = [sign stringByAppendingFormat:@"%@%@%@", [ActivateInfo sharedSingleton].deviceno,@"123456",signKey];
    
    DDLogDebug(@"Direct Login Md5 sign = %@,channel is %@", [MyMD5 md5:sign],[AppInfo sharedSingleton].channelID);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[ActivateInfo sharedSingleton].deviceno, @"username",
                                @"123456", @"password",
                                [AppInfo sharedSingleton].channelID,@"channel",
                                [AppInfo sharedSingleton].gameID, @"appid",
                                @"1",@"fromos",
                                [MyMD5 md5:sign], @"sign",nil];
    
    NSString *postData = [dictionary buildQueryString];
    DDLogDebug(@"Direct Login postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(directLogin_callback:);
    _request.error = @selector(directLogin_error);
    [_request post:API_URL_DIRECTLOG argData:postData];
}

-(void)directLogin_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
   // [UserData push:[ActivateInfo sharedSingleton].deviceno password:@"123456"]; //密文保存
    
    DDLogDebug(@"Anqu direct login info result = %@", result);//登录信息
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *status = [rootDic objectForKey:@"status"];
    NSString *message = [rootDic objectForKey:@"msg"];
    if([status intValue] == 0){
        NSString *uid = [rootDic objectForKey:@"uid"];
        NSString *vkey = [rootDic objectForKey:@"vkey"];
        [AnquUser sharedSingleton].uid = uid;
        [AnquUser sharedSingleton].sessiond = vkey;
        [AnquUser sharedSingleton].username = [ActivateInfo sharedSingleton].deviceno;
        //登录成功，callback
        [_delegate AnquLoginOn:AnquLoginOnSuccess];
        [[NSNotificationCenter defaultCenter] removeObserver:self];

    }else
    {
        [UserData showMessage:message]; //提示框
        [_delegate AnquLoginOn:AnquLoginOnFail];
        
        return;
    }
}

-(void)directLogin_error{
    if (_HUD != NULL){
        [_HUD hide:YES];
    }
    [UserData showMessage:@"网络不给力"];
    [_delegate AnquLoginOn:AnquNoLoginOn];
}

/**
 *  定额支付
 *
 *  @return 定额支付anquQuotaPay
 */

//{
//
//    QutoPayHome *pay = [[QutoPayHome alloc] init];
//    pay.delegate = _delegate;
//    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
//    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
//    [rootViewController presentModalViewController:pay animated:YES ];
//}


//-(void)anquOrderPay:(NSString*)money Subject:(NSString*)subject OutOrderId:(NSString*)mOutOrderid Body:(NSString*)body Pext:(NSString*)mPext
//{
//    NSLog(@"moneyllllllllll=%@",[OrderInfo sharedSingleton].money);
//
//    [OrderInfo sharedSingleton].outOrderid = mOutOrderid;
//    [OrderInfo sharedSingleton].subject = subject;
//    [OrderInfo sharedSingleton].body = body;
//    [OrderInfo sharedSingleton].pext = mPext;
//    [OrderInfo sharedSingleton].money = money;
//    //[OrderInfo sharedSingleton].uid = uid;
//    //[OrderInfo sharedSingleton].channelId = channelId;
//    //[OrderInfo sharedSingleton].roleId = roleld;
//    //[OrderInfo sharedSingleton].roleName = roleName;
//   // [OrderInfo sharedSingleton].type = mType;  //支付渠道当前不知道
//   // [OrderInfo sharedSingleton].cpappid = appId;
//   // [[OrderInfo sharedSingleton] createDescription];//生成描述
//
//   // [self anqupay];
//}

-(void)getAnalysisInfo{
    NSString *IDFA = [AnalysisInfo getIDFA];
    NSString *iOSVersion = [AnalysisInfo getiOSVersion];
    NSString *currentNet = [AnalysisInfo getCurrentNet];
    NSString *carrier = [AnalysisInfo getCarrier];
    NSString *deviceType = [AnalysisInfo getDeviceType];
    NSString *bundleID = [AnalysisInfo getBundleID];
    NSString *version = [AnalysisInfo getVersion];
    NSString *sysLanguage = [AnalysisInfo getSysLanguage];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                IDFA, @"IDFA",
                                iOSVersion,@"iOSVersion",
                                currentNet,@"CurrentNet",
                                carrier,@"Carrier",
                                deviceType,@"DeviceType",
                                bundleID,@"BundleID",
                                version,@"Version",
                                sysLanguage,@"SysLanguage",
                                nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *jsonValue = [writer stringWithObject:dictionary];
    
    NSString *password = @"p4ssw0rd";
    NSString *encryptedData = [AESCrypt encrypt:jsonValue password:password];
    
    NSDictionary *postDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                encryptedData, @"data",
                                nil];
    
    
    NSString *postData = [postDictionary buildQueryString];
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.error = @selector(error_callback);
    [_request post:API_URL_ANALYSIS argData:postData];
}

-(void)error_callback{
    NSLog(@"返回失败");
}

-(void)tomore
{
    NSUserDefaults *defaults=[CommonUtils getNSUserContext];
    
    RecommWeb * more= [[RecommWeb alloc] init];
    more.webUrl = [defaults objectForKey:moreLink];
    
    UIView* view = [[UIApplication sharedApplication] keyWindow].rootViewController.view;
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [rootViewController presentModalViewController:more animated:YES ];
    
    // [MTPopupWindow showWindowWithHTMLFile:[defaults objectForKey:moreLink] insideView:self.view];
}

@end
