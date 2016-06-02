//
//  BindPhone.m
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "BindPhone.h"

@interface BindPhone ()

@end

@implementation BindPhone

NSInteger bindSeconds = 90;//90秒倒计时
NSString *identCode = nil;
int ddLogLevel ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    [self initBindPhoneView];
    
    ddLogLevel = [AnquInterfaceKit getLoggerLevel];
    // Do any additional setup after loading the view.
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        self.userInteractionEnabled = YES;
//        [self initBindPhoneView];
//         ddLogLevel = [AnquInterfaceKit getLoggerLevel];
//    }
//    return self;
//}

-(void)initBindPhoneView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    
    //bgView.alpha = 0.5;
    //[self addSubview:bgView];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    _bindback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_bindback setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_bindback addTarget:self action:@selector(anquCloseClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_bindback];
    
    UILabel *anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(bg_width/2 - 50, 25, 100, 25)];
    anquTitle.textColor = UIColorFromRGB(0xFF6600);
    anquTitle.font = [UIFont systemFontOfSize:15.0];
    anquTitle.text = @"绑定手机";
    [self.view addSubview:anquTitle];

    _close = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(anquCloseClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_close];
    
    _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSpliterLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSpliterLine];
    
    _anquBindScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 56, SCREENWIDTH, SCREENHEIGHT - 60)];
    _anquBindScrollView.pagingEnabled = YES;
    _anquBindScrollView.delegate = self;
    _anquBindScrollView.showsVerticalScrollIndicator = NO;
    _anquBindScrollView.showsHorizontalScrollIndicator = NO;
    
    if (UIInterfaceOrientationIsLandscape( _orientation))
    {//横屏button布局
        CGSize newSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 30);
        [_anquBindScrollView setContentSize:newSize];
    }
    else
    {
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50);
        [_anquBindScrollView setContentSize:newSize];
    }
    
    [self.view addSubview:_anquBindScrollView];
    
    UIView *headTitle = [[UIView alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 40)];
    [_anquBindScrollView addSubview:headTitle];
    
    _anquTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 40, 30)];
    _anquTip.textColor = UIColorFromRGB(0xdd0000);
    _anquTip.font = [UIFont systemFontOfSize:12.0];
    _anquTip.text = @"为了您的账号安全,请尽快绑定手机，忘记密码后可及时通过手机找回";
    [headTitle addSubview:_anquTip];
  
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(20, 50, SCREENWIDTH - 40, 35)];
    [_anquBindScrollView addSubview:phoneView];
    
    _anquphone = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    _anquphone.text = @"手机号:";
    _anquphone.font = [UIFont systemFontOfSize:12.0];
    _anquphone.backgroundColor = [UIColor clearColor];
    _anquphone.textColor = [UIColor darkGrayColor];
    [phoneView addSubview:_anquphone];
     //手机号
    _anquPhoneEdit = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _anquPhoneEdit.placeholder = @" 请输入您的手机号";
    _anquPhoneEdit.delegate = self;
    _anquPhoneEdit.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquPhoneEdit.font = [UIFont systemFontOfSize:12.0];
    _anquPhoneEdit.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquPhoneEdit.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _anquPhoneEdit.returnKeyType= UIReturnKeyDone;
    [phoneView addSubview:_anquPhoneEdit];

    UIView *identView = [[UIView alloc] initWithFrame:CGRectMake(20, 105, SCREENWIDTH - 40, 35)];
    [_anquBindScrollView addSubview:identView];
    
    _anquIdent = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 60, 20)];
    _anquIdent.text = @"验 证 码  :";
    _anquIdent.font = [UIFont systemFontOfSize:12.0];
    _anquIdent.backgroundColor = [UIColor clearColor];
    _anquIdent.textColor = [UIColor darkGrayColor];
    [identView addSubview:_anquIdent];
    
    _anquIdentEdit = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 180, 35)];
    _anquIdentEdit.placeholder = @" 请输入您收到的验证码";
    _anquIdentEdit.delegate = self;
    _anquIdentEdit.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquIdentEdit.font = [UIFont systemFontOfSize:12.0];
    _anquIdentEdit.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquIdentEdit.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [identView addSubview:_anquIdentEdit];
    
    //获取验证码
    _anquGetIdent = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH -120, 0, 70, 35)];
    [_anquGetIdent setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquGetIdent setTitle:@"获取验证码" forState:UIControlStateNormal];
    _anquGetIdent.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_anquGetIdent addTarget:self action:@selector(anquGetIdentClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [identView addSubview:_anquGetIdent];
   
    //    UIImageView *userLogoImage=[[UIImageView alloc] initWithImage:[GetImage getSmallRectImage:@"anqu_login_user"]];
//    userLogoImage.frame = CGRectMake(50, 0, 25, 25);
//    _anquIdentEdit.leftView = userLogoImage;
//    _anquIdentEdit.leftViewMode = UITextFieldViewModeAlways;
    
    //提交
    _anquCommit = [[UIButton alloc] initWithFrame:CGRectMake(20, 165, SCREENWIDTH - 40, 50)];
    [_anquCommit setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquCommit setTitle:@"提    交" forState:UIControlStateNormal];
    _anquCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_anquCommit addTarget:self action:@selector(anquBindClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquBindScrollView addSubview:_anquCommit];

    
}

//倒计时
#pragma mark -Timer
-(void)timeFireMethod{
    bindSeconds--;
    NSString *tempStr = [NSString stringWithFormat:@"%d", bindSeconds];
    [_anquGetIdent setTitle:tempStr forState:UIControlStateNormal];
    if(bindSeconds==0){
        [_anquGetIdent setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_countDownTimer invalidate];
        [_anquGetIdent setUserInteractionEnabled:YES];
    }
}

-(void)anquCloseClick
{
    [self dismissModalViewControllerAnimated:YES];
}

+ (NSString*)getIdentcode
{

    NSArray *changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    
    //可变字符串，存取得到的随机数
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5];
    //可变string最终想要的验证码
    NSMutableString *randomCode = [[NSMutableString alloc] initWithCapacity:6];
    
    for(NSInteger i = 0; i < 6; i++) //得到六个随机字符
    {
        NSInteger index = arc4random() % ([changeArray count] - 1);  //得到数组中随机数的下标
        getStr = [changeArray objectAtIndex:index];  //得到数组中随机数，赋给getStr
       
        //把随机字符加到可变string后面
        randomCode = (NSMutableString *)[randomCode stringByAppendingString:getStr];
    }
  
    return randomCode;
    
}
//获取验证码
-(void)anquGetIdentClick:(id)sender
{
    NSString *phone = _anquPhoneEdit.text;
    if ([phone length] == 0)
    {
        [UserData showMessage:@"手机号不能为空"];
    }
    else if ([phone length] != 11)
    {
        [UserData showMessage:@"请输入正确的手机号码"];
    }else
    {
        identCode = [BindPhone getIdentcode];
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        _HUD.labelText = @"正在获取验证码...";
        _HUD.removeFromSuperViewOnHide = YES;
        [_HUD show: YES];
        
        _aliPost = [[httpRequest alloc] init];
        _aliPost.dlegate = self;
        _aliPost.success = @selector(get_callback:);
        _aliPost.error = @selector(get_error);
        
        // 登录请求
//        NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
//        NSString *partner = [dictionaryBundle objectForKey:@"cpuid"];
        NSString *sign = @"";
       // NSString *mTime = [[AppInfo sharedSingleton] getData];
//        NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
//        sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID,[ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].channelID, partner,[AnquUser sharedSingleton].uid, [AnquUser sharedSingleton].username, mTime ,[AppInfo sharedSingleton].gameKey];
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    [AnquUser sharedSingleton].uid, @"uid",
//                                    @"1",@"debug",
//                                    [AppInfo sharedSingleton].gameID, @"gameid",
//                                    [MyMD5 md5:sign], @"sign",
//                                    mTime, @"time",
//                                    [ActivateInfo sharedSingleton].deviceno, @"deviceno",
//                                    partner, @"partner",
//                                    [AppInfo sharedSingleton].channelID,@"referer",
//                                    [AnquUser sharedSingleton].username, @"username",//用户名
        
        sign = [sign stringByAppendingFormat:@"%@%@%@",phone,identCode,signKey];
        DDLogDebug(@"发送验证码Md5 sign = %@", [MyMD5 md5:sign]);
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [MyMD5 md5:sign], @"sign",
                                    phone,@"phone",
                                    identCode, @"key"//用户名
                                    ,nil];
        
        NSString *postData = [dictionary buildQueryString];
        
        DDLogDebug(@"postData modify=%@", [SEND_IDENT stringByAppendingFormat:@"%@", postData]);
        
        [_aliPost post:SEND_IDENT argData:postData];
        
        return;
    }
}

-(void)get_callback:(NSString*)tempResult
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    bindSeconds = 90;
    [_anquGetIdent setUserInteractionEnabled:NO];
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    return;
}

-(void)get_error
{
    [UserData showMessage:@"网络不给力"];
}

//提交
-(void)anquBindClick:(id)sender
{
    NSString *phoneText = _anquPhoneEdit.text;
    NSString *idenText = _anquIdentEdit.text;
    if (phoneText.length == 0) {
        [UserData showMessage:@"手机号不能为空"];
        return;
    }else if(phoneText.length != 11){
        [UserData showMessage:@"手机号为11位,请您检查"];
        return;
    }else if(idenText.length == 0){
        [UserData showMessage:@"验证码不能为空"];
        return;
    }else{
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        //HUD.delegate = self;
        _HUD.removeFromSuperViewOnHide = YES;
        _HUD.dimBackground = YES;
        _HUD.labelText = @"正在绑定...";
        [_HUD show: YES];
        
        if(![identCode isEqualToString:idenText]){  //验证码不对
            [UserData showMessage:@"输入的验证码不正确，请重新输入"];
            return;
        }
        httpRequest *bindpost = [[httpRequest alloc] init];
        bindpost.dlegate = self;
        bindpost.success = @selector(bind_callback:);
        bindpost.error = @selector(bind_error);
        
        // 绑定请求
//        NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
//        NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
        NSString *sign = @"";
        NSString *mTime = [[AppInfo sharedSingleton] getData];
      //  NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
        
//        sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID,[ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].channelID, partner,[AnquUser sharedSingleton].uid, [AnquUser sharedSingleton].username, mTime ,[AppInfo sharedSingleton].gameKey];
    sign = [sign stringByAppendingFormat:@"%@%@%@",[AnquUser sharedSingleton].uid,phoneText,signKey];
        
        DDLogDebug(@"Md5 sign = %@", [MyMD5 md5:sign]);
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [AnquUser sharedSingleton].uid, @"uid",
                                    [MyMD5 md5:sign], @"sign",
                                    [AnquUser sharedSingleton].username, @"username",//用户名
                                     phoneText, @"phone", nil];
        
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    [AnquUser sharedSingleton].uid, @"uid",
//                                    @"1",@"debug",
//                                    [AppInfo sharedSingleton].gameID, @"gameid",
//                                    [MyMD5 md5:sign], @"sign",
//                                    mTime, @"time",
//                                    [ActivateInfo sharedSingleton].deviceno, @"deviceno",
//                                    partner, @"partner",
//                                    [AppInfo sharedSingleton].channelID,@"referer",
//                                    [AnquUser sharedSingleton].username, @"passport",//用户名
//                                
//                                    phoneText, @"phone",
//                                    idenText, @"code",
//                                    nil];
        
        NSString *postData = [dictionary buildQueryString];
        
        DDLogDebug(@"postData modify=%@", [BIND_PHONE stringByAppendingFormat:@"%@", postData]);
        
        [bindpost post:BIND_PHONE argData:postData];
        
    }
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


#pragma mark -BindPhone
-(void)bind_callback:(NSString*)tempResult
{
    DDLogDebug(@"绑定返回结果=%@",tempResult);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:tempResult];
    NSString *status = [[rootDic objectForKey:@"status"] stringValue];
    
    DDLogDebug(@"绑定status = %@",status);
    if([status isEqualToString:@"0"]){
        DDLogInfo(@"绑定成功");
        [_HUD hide:YES];
        [UserData showMessage:@"客官，手机绑定成功！"];
        
//    [self dismissModalViewControllerAnimated:YES];
    //[self removeFromSuperview];
    }else{
         [_HUD hide:YES];
        NSString *message = [rootDic objectForKey:@"msg"];
         [UserData showMessage:message];
        return;
        
    }
}

-(void)bind_error
{
    [UserData showMessage:@"连接超时"];
}


#pragma -mark UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {//如果机型是iPhone
        
        if (UIInterfaceOrientationIsPortrait(_orientation)) {//是竖屏
            offset = frame.origin.y + 200 - (self.view.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 180 - (self.view.frame.size.height -216.0);
        }
        
    }else{//机型是ipad
        if (UIInterfaceOrientationIsPortrait(_orientation)) {//是竖屏
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
        if (UIInterfaceOrientationIsPortrait(_orientation) ) {//是竖屏
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
    self.view.frame =CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
}

//触摸view隐藏键盘——touchDown

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
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
