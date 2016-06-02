//
//  LoginOut.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "LoginOut.h"
#import "Login.h"

@interface LoginOut ()

@end

@implementation LoginOut

int ddLogLevel;

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
    
    ddLogLevel =[AnquInterfaceKit getLoggerLevel];
    
    //_orientation = [UIApplication sharedApplication].statusBarOrientation;
    _orientation = [AnquInterfaceKit getOrientation];
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anquAcountBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _anquPayText.text = @"账户注销";
    _anquPayText.font = [UIFont systemFontOfSize:20.0];
    _anquPayText.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(anquAcountCustomClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 90, 40, 20)];
    _anquTitle.text = @"尊敬的:";
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_anquTitle];
    
    _anquUserName = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 90, 60, 20)];
    _anquUserName.text = [AnquUser sharedSingleton].username;
    _anquUserName.font = [UIFont systemFontOfSize:12.0];
    _anquUserName.textColor = [UIColor orangeColor];
    [self.view addSubview:_anquUserName];
    
    _anquPlay = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/3, SCREENHEIGHT/2-100, 180, 20)];
    _anquPlay.text = @"您确定要退出当前账号吗？";
    _anquPlay.font = [UIFont systemFontOfSize:14.0];
    _anquPlay.textColor = [UIColor orangeColor];
    [self.view addSubview:_anquPlay];
    
    
//    UIImageView *anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 90, SCREENHEIGHT/2 - 50, 180, 100)];
//    [anquEditFrame setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
//    [self.view addSubview:anquEditFrame];
    
    //安趣的logo
//    _anquLogo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
//    _anquLogo.image = [GetImage imagesNamedFromCustomBundle:@"anqu_back_icon_large"];
//    [anquEditFrame addSubview:_anquLogo];
    
    //第二版根据appid后台查询得到
  /*  _anquGameId = [[UILabel alloc] initWithFrame:CGRectMake(65, 20, 120, 20)];
    _anquGameId.text = @"游戏名称:%@"; //第二版根据appid后台查询得到
    _anquGameId.font = [UIFont systemFontOfSize:12.0];
    _anquGameId.backgroundColor = [UIColor clearColor];
    _anquGameId.textColor = [UIColor orangeColor];
    [anquEditFrame addSubview:_anquGameId];
    
    _anquGameVersion = [[UILabel alloc] initWithFrame:CGRectMake(65, 40, 120, 20)];
    _anquGameVersion.text = @"游戏版本:1.0";//第二版根据appid后台查询得到
    _anquGameVersion.backgroundColor = [UIColor clearColor];
    _anquGameVersion.font = [UIFont systemFontOfSize:12.0];
    _anquGameVersion.textColor = [UIColor orangeColor];
    [anquEditFrame addSubview:_anquGameVersion];
   */
    
    _anquLoginOutButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 90, SCREENHEIGHT/2, 180, 50)];
    [_anquLoginOutButton setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquLoginOutButton setTitle:@"确  定" forState:UIControlStateNormal];
    _anquLoginOutButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_anquLoginOutButton addTarget:self action:@selector(anquLoginOutClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_anquLoginOutButton];
    
//    _anquLoginOutButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 55, SCREENHEIGHT/2 + 70, 180, 50)];
//    [_anquLoginOutButton setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_login_bt"] forState:UIControlStateNormal];
//    [_anquLoginOutButton setTitle:@"确定" forState:UIControlStateNormal];
//    _anquLoginOutButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    [_anquLoginOutButton addTarget:self action:@selector(yyLoginOutClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
//    [self.view addSubview:_anquLoginOutButton];
    
    // Do any additional setup after loading the view.
}

-(void)anquAcountBackClick
{
   // [self dismissModalViewControllerAnimated:YES];
    Login *anquLogin = [[Login alloc] init];
    [self  presentViewController:anquLogin animated:NO completion:^{NSLog(@"进入Login");}];
    
}

-(void)anquAcountCustomClick
{
    [self dismissModalViewControllerAnimated:YES];
     
}


-(void)anquLoginOutClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"LoginOut_close" object:nil];
}

-(void)anquLoginOutClick:(id)sender
{
    //[self loadAvatarInKeyWindow];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人,正在退出登录中...";
    [_HUD show: YES];
    
//    NSString *sign = @"";
//    NSString *mTime = [[AppInfo sharedSingleton] getData];
//    sign = [sign stringByAppendingFormat:@"%@%@", _passport,signKey];
//    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [AnquUser sharedSingleton].uid, @"uid",
                                [AnquUser sharedSingleton].sessiond, @"vkey",nil];
    
    NSString *postData = [dictionary buildQueryString];
    DDLogDebug(@"退出postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(logout_callback:);
    _request.error = @selector(logout_error);
    [_request post:API_URL_LOGOUT argData:postData];
    
}

-(void)logout_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    DDLogDebug(@"Anqu logout result = %@", result);//登录信息
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *status = [rootDic objectForKey:@"status"];
   
    if([status intValue] == 0){
        //登出成功，callback
        // NSLog(@"安趣退出登录成功 ");
        [AnquUser sharedSingleton].username = nil;
        [AnquUser sharedSingleton].uid = nil;
        
        [_delegate AnquLoginOut:AnquLogoutSuccess];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        [[NSNotificationCenter  defaultCenter]postNotificationName:@"LoginOut_close" object:nil];
        
    }else
    {
        [_delegate AnquLoginOut:AnquLogoutFail];
        [UserData showMessage:[rootDic objectForKey:@"msg"]];
        return;
    }
}

-(void)logout_error{
    if (_HUD != NULL)
    {
        [_HUD hide:YES];
    }
    
    [UserData showMessage:@"网络不给力"];
    [_delegate AnquLoginOut:AnquLogoutFail];
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
