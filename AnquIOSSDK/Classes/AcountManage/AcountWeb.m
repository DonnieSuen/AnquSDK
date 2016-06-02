//
//  AcountWeb.m
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "AcountWeb.h"

@interface AcountWeb ()

@end

@implementation AcountWeb

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
    // Do any additional setup after loading the view.
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anquPayBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
   
    switch (_payway)
    {
        case 1:
            _anquPayText.text = @"客服中心";
            break;
        case 2:
            _anquPayText.text = @"论坛";
            break;
            
        case 3:
            _anquPayText.text = @"活动";
            break;
            
        default:
            _anquPayText.text = @"游戏";
            break;
    }
    
    _anquPayText.font = [UIFont systemFontOfSize:14.0];
    _anquPayText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_anquPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(anquPayBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, SCREENHEIGHT - 55)];
    _webView.scalesPageToFit =YES;
    _webView.delegate =self;
    [self.view addSubview:_webView];
    
}

#pragma mark -VillApper
/*
 -(void)viewWillAppear:(BOOL)animated{
 _HUD = [[MBProgressHUD alloc] initWithView:self.view];
 [self.view addSubview:_HUD];
 _HUD.removeFromSuperViewOnHide = YES;
 _HUD.dimBackground = YES;
 _HUD.labelText = @"正在加载中...";
 [_HUD show: YES];
 
 NSLog(@"_webUrl = %@", _webUrl);
 
 // 登录请求
 NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
 NSString *partner = [dictionaryBundle objectForKey:@"Partner"]; //appid
 NSString *sign = @"";
 NSString *mTime = [[AppInfo sharedSingleton] getData];
 //NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
 
 NSString *deviceNo = [ActivateInfo sharedSingleton].deviceno;
 NSString *gameID = [AppInfo sharedSingleton].gameID;
 NSString *channelID = [AppInfo sharedSingleton].channelID;
 NSString *uid = [AnquUser sharedSingleton].uid;
 NSString *password = [AnquUser sharedSingleton].passwd;
 NSString *userName = [AnquUser sharedSingleton].username;
 NSString *servID = [OrderInfo sharedSingleton].serverId;
 NSString *roleID = [OrderInfo sharedSingleton].roleId;
 NSString *serverName = [OrderInfo sharedSingleton].serverName;
 NSString *roleName = [OrderInfo sharedSingleton].roleName;
 NSString *appKey = [AppInfo sharedSingleton].gameKey;
 
 sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", deviceNo, gameID, partner, channelID, uid, userName, password, servID, roleID, roleName, serverName, appKey];
 NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
 NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:gameID, @"gameid",
 deviceNo, @"deviceno",
 channelID,@"referer",
 partner, @"partner",
 uid, @"uid",
 userName, @"passport",//用户名
 serverName, @"serverName",//游戏服名
 roleName, @"roleName",//充值角色
 
 mTime, @"time",
 [MyMD5 md5:sign], @"sign",
 @"1",@"debug",
 [OrderInfo sharedSingleton].pext, @"pext",nil];
 NSString *postData = [dictionary buildQueryString];
 
 if (_payway == 1)
 {
 _payUrl = QPAGE_URL;  //客服中心
 }
 else if (_payway == 2)
 {
 _payUrl = FORUMPAGE_URL;  //论坛
 }
 else if (_payway == 3)
 {
 _payUrl = ANNOUNCEMENTSPAGE_URL;  //活动
 }
 
 NSLog(@"last post =%@", [_payUrl stringByAppendingFormat:@"%@%@", @"?", postData]);
 _payDelegateUrl = [_payUrl stringByAppendingFormat:@"%@%@", @"?", postData];
 
 NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_payDelegateUrl]];
 [_webView loadRequest:request];
 }
 
 */


//监听webView的事件，可以获得webview加载页面的url
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    //获取当前调转页面的URL
    //    NSString *requestUrl = [[request URL] absoluteString];
    //
    //    if ([requestUrl hasPrefix:@"yayapayment://success"] == 1) {
    //
    //        NSDictionary *url_info = [NSDictionary dictionaryWithQueryString:requestUrl];
    //
    //        int status = [[url_info objectForKey:@"status"] intValue];
    //
    //        if (status == 0) {
    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"finish" object:@"0"];
    //        }else{
    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"finish" object:@"1"];
    //        }
    //        [self dismissViewControllerAnimated:YES completion:nil];
    //        return NO;
    //
    //    }
    
    return  YES;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_HUD hide:YES afterDelay:1];
    NSLog(@"加载完成");
    //    [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_HUD hide:YES afterDelay:1];
    if ([error code] == NSURLErrorCancelled) {
        [_HUD hide:YES afterDelay:1];
        //show error alert, etc.
        return;
    }
}

-(void)anquPayBackClick:(id)sender{
    if (_webView.canGoBack)
    {
        [_webView goBack];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
