//
//  Register.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "Register.h"
#import "Login.h"

@interface Register ()

@end

@implementation Register

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
    _orientation = [AnquInterfaceKit getOrientation];
    UIColor *mycolor =[UIColor colorWithWhite:0.5 alpha:0.7];
    self.view.backgroundColor =  mycolor;
    
    [self initRegisterView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initPortraitRegister{
    _anquLoginBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREENWIDTH,SCREENHEIGHT)];
    _anquLoginBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREENWIDTH,SCREENHEIGHT)];
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/3, 25, SCREENWIDTH/2, 25)];
    _back = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 45, 45)];
    _close = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 60, 15, 45, 45)];
    _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, SCREENWIDTH-30, 1)];
    _anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/6, 70, SCREENWIDTH/2+SCREENWIDTH/7, 100)];
    _anquLoginUser = [[UITextField alloc] initWithFrame:CGRectMake(SCREENWIDTH/6, 70, SCREENWIDTH/2+SCREENWIDTH/7, 50)];
    _inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/6, 120, SCREENWIDTH/2+SCREENWIDTH/7, 1)];
    _anquLoginPwd = [[UITextField alloc] initWithFrame:CGRectMake(SCREENWIDTH/6, 120, SCREENWIDTH/2+SCREENWIDTH/7, 50)];
    
    _anquRemPwd = [[QCheckBox alloc] initWithDelegate:self];
    [_anquRemPwd setFrame: CGRectMake(SCREENWIDTH/6, 180, 180, 50)];
    _anquLoginNowBt = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/6, 230, SCREENWIDTH/2+SCREENWIDTH/7, 35)];
}

-(void) initLandRegister{
    CGFloat bg_height = 290;
    
    _anquLoginBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,bg_height)];
    _anquLoginBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, bg_height)];
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 50, 25, 100, 25)];
    _back = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 45, 45)];
    _close = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 60, 15, 45, 45)];
    _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60,SCREENWIDTH-30, 1)];
    _anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, SCREENWIDTH-80, 100)];
    _anquLoginUser = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, SCREENWIDTH-80, 50)];
    _inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, SCREENWIDTH-80, 1)];
    _anquLoginPwd = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, SCREENWIDTH-80, 50)];
    
    _anquRemPwd = [[QCheckBox alloc] initWithDelegate:self];
    [_anquRemPwd setFrame:CGRectMake(25, 180, 180, 50)];
    _anquLoginNowBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 230, SCREENWIDTH-40, 35)];
}

-(void)initRegisterView
{
    DDLogDebug(@"register横着还是竖着=%ld",UIInterfaceOrientationIsLandscape(_orientation));
    if (_orientation == UIInterfaceOrientationUnknown) {
        DDLogDebug(@"reg方向未定");
        CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
        CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
        
        _anquLoginBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,min,min)];
        _anquLoginBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,min,min)];
        _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(min/2 - 50, 25, 100, 25)];
        _back = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 45, 45)];
        _close = [[UIButton alloc] initWithFrame:CGRectMake(min - 60, 15, 45, 45)];
        _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60,min-30, 1)];
         _anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, min-80, 100)];
        _anquLoginUser = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, min-80, 50)];
        _inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, min-80, 1)];
        _anquLoginPwd = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, min-80, 50)];
        
         _anquRemPwd = [[QCheckBox alloc] initWithDelegate:self];
        [_anquRemPwd setFrame: CGRectMake(25, 180, 180, 50)];
        _anquLoginNowBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 230, min-40, 35)];
        
    }
    else if (UIInterfaceOrientationIsPortrait( _orientation) && UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) { //竖版
        DDLogDebug(@"register竖版");
        [self initPortraitRegister];
    }
    
    else{
        DDLogDebug(@"register横版");
        [self initLandRegister];
        
    }
         [self.view addSubview:_anquLoginBgView];
    
         [_anquLoginBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
         [_anquLoginBgImageView setImage:[GetImage getRectImage:@"anqu_login_bg"]];
         [_anquLoginBgView addSubview:_anquLoginBgImageView];
    
        _anquTitle.textColor = UIColorFromRGB(0xFF6600);
         _anquTitle.font = [UIFont systemFontOfSize:20.0];
         _anquTitle.text = UserRegisterText;
         [_anquLoginBgView addSubview:_anquTitle];
    
         [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
         [_back addTarget:self action:@selector(anqubackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
         [_anquLoginBgView addSubview:_back];
    
         [_close setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
         [_close addTarget:self action:@selector(anquRegisterClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
         [_anquLoginBgView addSubview:_close];
    
         [_anquSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_split_line"]];
         [_anquLoginBgView addSubview:_anquSpliterLine];
    
         [_anquEditFrame setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
         [_anquLoginBgView addSubview:_anquEditFrame];
         
         //用户名
        _userleftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 50)];
         _userLogoImage=[[UIImageView alloc] initWithImage:[GetImage imagesNamedFromCustomBundle:@"anqu_login_user"]];
         _userLogoImage.contentMode = UIViewContentModeScaleToFill;
         _userLogoImage.frame = CGRectMake(7, 12, 25, 25);
         [_userleftview addSubview:_userLogoImage];
         _anquLoginUser.leftView = _userleftview;
         _anquLoginUser.leftViewMode = UITextFieldViewModeAlways;
         _anquLoginUser.placeholder = @" 账号:推荐首选手机号/数字字母组合";
         _anquLoginUser.clearButtonMode = UITextFieldViewModeWhileEditing;
         _anquLoginUser.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
         _anquLoginUser.delegate = self;
         _anquLoginUser.font = [UIFont systemFontOfSize:12.0];
         [_anquLoginBgView addSubview:_anquLoginUser];
    
         [_inputSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_split_line"]];
         [_anquLoginBgView addSubview:_inputSpliterLine];
         
         //密码
         _leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 50)];
         _passwdLogoImage=[[UIImageView alloc] initWithImage:[GetImage imagesNamedFromCustomBundle:@"anqu_input_pwd"]];
         _passwdLogoImage.frame = CGRectMake(7, 12, 25, 25);
         [_leftview addSubview:_passwdLogoImage];
         _anquLoginPwd.leftView = _leftview;
         _anquLoginPwd.leftViewMode = UITextFieldViewModeAlways;
         _anquLoginPwd.placeholder = @" 密码:6-20位字母、数字、下划线";
         _anquLoginPwd.delegate = self;
         [_anquLoginPwd setSecureTextEntry:TRUE];
         _anquLoginPwd.font = [UIFont systemFontOfSize:12.0];
         _anquLoginPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
         _anquLoginPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
         [_anquLoginBgView addSubview:_anquLoginPwd];
    
         [_anquRemPwd setTitle:@"同意《用户服务条款》" forState:UIControlStateNormal];
         [_anquRemPwd setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         [_anquRemPwd.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
         [_anquLoginBgView addSubview:_anquRemPwd];
         
         //立即登录
         [_anquLoginNowBt setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
         [_anquLoginNowBt setTitle:@"立即注册" forState:UIControlStateNormal];
         _anquLoginNowBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
         [_anquLoginNowBt addTarget:self action:@selector(anquLoginNowClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
         [_anquLoginBgView addSubview:_anquLoginNowBt];
    
    
}

-(void)anqubackClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self removeFromParentViewController];
    
}

-(void)anquRegisterClick:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        //[self dismissModalViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
       // [self removeFromParentViewController];
    });
}

-(void)anquLoginNowClick
{
    if (_anquLoginUser.text.length < 6|| _anquLoginUser.text.length > 20) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名输入错误(6-20个字符)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (_anquLoginPwd.text.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码输入错误(6-20个字符)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(![checkWifi connectedToNetWork]){//|| ![checkWifi IsEnable3G] || ![checkWifi IsEnableWIFI]
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接错误，请检查网络是否正常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (_anquRemPwd.checked == YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请同意用户协议" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走，正在加载中...";
    [_HUD show: YES];
    
    DDLogDebug(@"passport用户名 = %d", [[ActivateInfo sharedSingleton].relationships intValue]);

    if (_anquLoginUser.text != [ActivateInfo sharedSingleton].passport) {
        _fastreg = 0;
    }
    
    _passport = _anquLoginUser.text;
    
    // 登录请求
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    //ßNSString *partner = [dictionaryBundle objectForKey:@"Partner"];
    
    NSString *sign = @"";
//    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID, [ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].channelID, partner, _passport,_anquLoginPwd.text,[[AppInfo sharedSingleton] getData], [AppInfo sharedSingleton].gameKey];
    
    //[ActivateInfo sharedSingleton].deviceno, @"deviceno",
     sign = [sign stringByAppendingFormat:@"%@%@%@", _passport,_anquLoginPwd.text,signKey];
    DDLogDebug(@"sign = %@", sign);
    DDLogDebug(@"注册时签名Md5 = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AppInfo sharedSingleton].gameID, @"gameid",
                                
                                [AppInfo sharedSingleton].channelID,@"channel",
                                [AppInfo sharedSingleton].gameID, @"appid",
                                _passport, @"username",//用户名
                                _anquLoginPwd.text, @"password",//密码
                                @"1",@"fromos",
                                 [MyMD5 md5:sign], @"sign",nil];
                               // [NSString stringWithFormat:@"%d", _fastreg], @"fastreg",
                              //  [[AppInfo sharedSingleton] getData], @"time",
                              //  @"1",@"debug",
                               
    
    NSString *postData = [dictionary buildQueryString];
    DDLogDebug(@"注册时postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(register_callback:);
    _request.error = @selector(register_error);
    [_request post:API_URL_REGISTER argData:postData];
}

-(void)register_error
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接不给力" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)register_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    //注册成功，录入信息
    [UserData push:_anquLoginUser.text password:_anquLoginPwd.text];
    
    DDLogDebug(@"注册后login info result = %@", result);//登录信息
    
    //如果是ios的，服务端注册成功就进行登陆  下一版
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *status = [rootDic objectForKey:@"status"];
   // NSDictionary *data = [rootDic objectForKey:@"data"];
    NSString *uid = [rootDic objectForKey:@"uid"];
    NSString *sessionid =nil;// [data objectForKey:@"sessionid"];
    [[AnquUser sharedSingleton] initWithType:_passport Pwd:_anquLoginPwd.text Sessiond:sessionid Uid:uid];
    
    if ([status intValue] == 1)
    {
        //激活成功，callback
        [self dismissModalViewControllerAnimated:NO];
       // [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[rootDic objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}


// 支持横竖屏显示
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}

#pragma -mark UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {//如果机型是iPhone
        
        if (UIInterfaceOrientationIsPortrait( _orientation)) {//是竖屏
            offset = frame.origin.y + 200 - (self.view.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 200 - (self.view.frame.size.height -216.0);
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
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
            self.view.frame =CGRectMake(0.0f, -offset,self.view.frame.size.width,self.view.frame.size.height);//-offset 0.0f
        }else{
            self.view.frame =CGRectMake(0, 0.0f,self.view.frame.size.width,self.view.frame.size.height);//-offset 0.0f
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


#pragma mark - QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
    tipValue = REGISTER_SERVER;
    QutoPayTip *tip = [[QutoPayTip alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [self.view addSubview:tip];
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
