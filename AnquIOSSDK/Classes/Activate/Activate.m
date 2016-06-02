//
//  Activate.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "Activate.h"

//#define SCREENHEIGHT [GetImage screenSize].height
//#define SCREENWIDTH [GetImage screenSize].width

@interface Activate ()

@end
/**
 *  CP商渠道号，游戏ID，游戏ID，渠道号从Anqu后台获取
 *  @param AppId       游戏ID
 *  @param argSourceId 渠道ID
 *  @param argGameKey 游戏key
 */

@implementation Activate{
    int ddLogLevel ;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) initView
{
     ddLogLevel = [AnquInterfaceKit getLoggerLevel];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //_anquLogo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 30, 40, 160, 160)];
    
    if ([AnquInterfaceKit getOrientation] !=UIInterfaceOrientationMaskPortrait) {
        _anquLogo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENHEIGHT/9, SCREENWIDTH/4, SCREENHEIGHT/2,SCREENWIDTH-30)];
    }else{
        _anquLogo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/9, SCREENHEIGHT/4, SCREENWIDTH/2, SCREENHEIGHT-30)];
    }
    
    _anquLogo.image = [GetImage imagesNamedFromCustomBundle:@"anqu_icon_back_large"];
    [self.view addSubview:_anquLogo];
  

}


-(void) activiateToAnqu:(UIViewController*)viewController{
    ddLogLevel = [AnquInterfaceKit getLoggerLevel];
    
    [viewController.view setBackgroundColor:[UIColor clearColor]];
    //_anquLogo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 30, 40, 160, 160)];
    
//    if ([AnquInterfaceKit getOrientation] !=UIInterfaceOrientationMaskPortrait) {
//        _anquLogo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENHEIGHT/9, SCREENWIDTH/4, SCREENHEIGHT/2,SCREENWIDTH-30)];
//    }else{
//        _anquLogo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/9, SCREENHEIGHT/4, SCREENWIDTH/2, SCREENHEIGHT-30)];
//    }
//    
//    _anquLogo.image = [GetImage imagesNamedFromCustomBundle:@"anqu_icon_back_large"];
//    [viewController.view addSubview:_anquLogo];
    
    //设置loading
    _HUD = [[MBProgressHUD alloc] initWithView:viewController.view];
    [viewController.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在初始化...";
    [_HUD show: YES];
    
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    NSString *channelID = [dictionaryBundle objectForKey:@"ChannelID"];
    NSString *appid = [dictionaryBundle objectForKey:@"AppID"];
    NSString *cpuid = [dictionaryBundle objectForKey:@"cpuid"];
    NSString *appkey = [dictionaryBundle objectForKey:@"Appkey"];
    NSString *privateKey = [dictionaryBundle objectForKey:@"PrivateKey"];
    
    [AppInfo sharedSingleton].channelID = channelID;
    [AppInfo sharedSingleton].partnerID =  cpuid;
    [AppInfo sharedSingleton].gameID = appid;
    [AppInfo sharedSingleton].gameKey = appkey;

    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                appid, @"appid",
                                cpuid, @"cpuid",
                                appkey,@"appkey",
                                channelID,@"channel",
                                privateKey,@"privatekey", nil
                                ];
    
    //#import "NSDictionary+QueryBuilder.h"
    
    NSString *postData = [dictionary buildQueryString];
    
     NSLog(@"初始化render数据：%@,url is %@",postData,API_URL_ACTIVATE);
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(active_callback:);
    _request.error = @selector(active_error_callback);
    [_request post:API_URL_ACTIVATE argData:postData];
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  //  [self initView];
    
    [self activiateToAnqu:self];
    
    //激活信息
    //    NSString *sign = @"";
//    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID, [AppInfo sharedSingleton].channelID, [dictionaryBundle objectForKey:@"cpuid"], [SvUDIDTools UDID], [SvUDIDTools UDID],[[AppInfo sharedSingleton] getData], [AppInfo sharedSingleton].gameKey];
//    NSLog(@"sign = %@", sign);
//    CGFloat scale_screen = [UIScreen mainScreen].scale;
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AppInfo sharedSingleton].gameID, @"gameid",
//  [AppInfo  sharedSingleton].channelID,@"referer",partner, @"partner",
//  [SvUDIDTools UDID], @"mac",[SvUDIDTools UDID], @"imei",
//  [NSString stringWithFormat:@"%f",SCREENWIDTH*scale_screen], @"wpixels",
//   [NSString stringWithFormat:@"%f",SCREENHEIGHT*scale_screen], @"hpixels",
//   [UIDevice currentDevice].model, @"mode",[SvUDIDTools deviceName], @"mode",
//   [[UIDevice currentDevice] systemName], @"os", [[UIDevice currentDevice] systemVersion],   @"osver",[[AppInfo sharedSingleton] getData], @"time",[MyMD5 md5:sign], @"sign",
//   [[UIDevice currentDevice] identifierForVendor], @"device",nil];
        //第二版本加入签名和设备认证[SvUDIDTools UDID]
    
    // Do any additional setup after loading the view from its nib.
}

-(void)active_error_callback
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    [UserData showMessage:@"网络连接超时"];
    [_delegate AnquInit:AnquNoInit];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)active_callback:(NSString*)result
{
    
    //static const int ddLogLevel = LOG_FLAG_ERROR | LOG_FLAG_INFO;
    DDLogDebug(@"激活初始化 result = %@",result);
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    
    // NSString *status = [NSString stringWithFormat:@"%d",[rootDic objectForKey:@"status"]];
    NSString *status = [[rootDic objectForKey:@"status"] stringValue];
    
    //NSLog(@"初始化status = %@",status);
    if([status isEqualToString:@"0"]){
        [ActivateInfo sharedSingleton].deviceno =  [SvUDIDTools UDID];
        DDLogDebug(@"初始化成功，设备号= %@",[ActivateInfo sharedSingleton].deviceno);
       
        if (_HUD != NULL) {
            [_HUD hide:YES];
        }
         sleep(2);
        //激活成功，callback
        [_delegate AnquInit:AnquInitSuccess];
        [self dismissModalViewControllerAnimated:NO];
       
        
        [self dismissViewControllerAnimated:NO completion:^{
            DDLogDebug(@"初始化。。。成功");
            [_delegate AnquInit:AnquInitSuccess];
        }];

        
    }else{
        if (_HUD != NULL) {
            [_HUD hide:YES];
        }
        
        [_delegate AnquInit:AnquInitFail];
        return;
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   //  [self.presentedViewController beginAppearanceTransition: YES animated: animated];
}

-(void) viewDidAppear:(BOOL)animated
{
  //  [self.presentedViewController endAppearanceTransition];
}

-(void) viewWillDisappear:(BOOL)animated
{
    //[self.presentedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
  //  [self.presentedViewController endAppearanceTransition];
}





@end
