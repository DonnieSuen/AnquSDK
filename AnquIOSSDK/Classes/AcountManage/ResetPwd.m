//
//  ResetPwd.m
//  AnquIOSSDK
//
//  Created by jiangfeng on 15/4/14.
//  Copyright (c) 2015年 anqu. All rights reserved.
//


#import "ResetPwd.h"

@interface ResetPwd ()

@end

@implementation ResetPwd

NSInteger resetbindSeconds = 90;//90秒倒计时
NSString *resetidentCode = nil;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        self.userInteractionEnabled = YES;
//        [self initResetPwdView];
//    }
//    return self;
//}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//   
//    [textField becomeFirstResponder];
//    return YES;
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    // NSLog(@"abc-return");
//    [textField resignFirstResponder];
//    return YES;
//}

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
    self.view.frame =CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
}

//触摸view隐藏键盘——touchDown

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    [self initResetPwdView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
}

-(void)initResetPwdView
{
    _isbinded = nil;
    
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _retback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_retback setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_retback addTarget:self action:@selector(anquCloseClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_retback];
    
    
    UILabel *anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80,
                                                                   50)];
    anquTitle.textColor = UIColorFromRGB(0xFF6600);
    anquTitle.font = [UIFont systemFontOfSize:15.0];
    anquTitle.text = @"重置密码";
    [self.view addSubview:anquTitle];
    
    _close =  [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(anquCloseClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_close];

    _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSpliterLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSpliterLine];
    
    _anquResetScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 56, SCREENWIDTH, SCREENHEIGHT - 60)];
    _anquResetScrollView.pagingEnabled = YES;
    _anquResetScrollView.delegate = self;
    _anquResetScrollView.showsVerticalScrollIndicator = NO;
    _anquResetScrollView.showsHorizontalScrollIndicator = NO;

    if (UIInterfaceOrientationIsLandscape( _orientation))
    {//横屏button布局
        CGSize newSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 30);
        [_anquResetScrollView setContentSize:newSize];
    }
    else
    {
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50);
        [_anquResetScrollView setContentSize:newSize];
    }
    
    [self.view addSubview:_anquResetScrollView];
    
    UIView *headTitle = [[UIView alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 40)];
    [_anquResetScrollView addSubview:headTitle];
    
        _anquTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 40, 30)];
        _anquTip.textColor = UIColorFromRGB(0xdd0000);
        _anquTip.font = [UIFont systemFontOfSize:12.0];
        _anquTip.text = @"绑定手机，忘记密码后可及时通过手机找回";
        [headTitle addSubview:_anquTip];
    
//    _anquBindTip = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 20)];
//        _anquBindTip.textColor = UIColorFromRGB(0x999999);
//        _anquBindTip.font = [UIFont systemFontOfSize:11.0];
//        _anquBindTip.text = @"绑定手机，忘记密码后可及时通过手机找回";
//        [headTitle addSubview:_anquBindTip];
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(20, 50, SCREENWIDTH - 40, 35)];
    [_anquResetScrollView addSubview:phoneView];
    
    _anquphone = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    _anquphone.text = @"手机号:";
    _anquphone.font = [UIFont systemFontOfSize:12.0];
    _anquphone.backgroundColor = [UIColor clearColor];
    _anquphone.textColor = [UIColor darkGrayColor];
    [phoneView addSubview:_anquphone];
    
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
    [_anquResetScrollView addSubview:identView];
    
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
    [_anquGetIdent addTarget:self action:@selector(anquValidUser:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [identView addSubview:_anquGetIdent];
    
    UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(20, 150, SCREENWIDTH - 40, 35)];
    [_anquResetScrollView addSubview:pwdView];
    
    _anquPwd = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 60, 20)];
    _anquPwd.text = @"重置密码:";
    _anquPwd.font = [UIFont systemFontOfSize:12.0];
    _anquPwd.backgroundColor = [UIColor clearColor];
    _anquPwd.textColor = [UIColor darkGrayColor];
    [pwdView addSubview:_anquPwd];
    
    _anquPwdEdit = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _anquPwdEdit.placeholder = @" 请输入您的重置密码";
    _anquPwdEdit.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquPwdEdit.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquPwdEdit.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _anquPwdEdit.delegate = self;
    _anquPwdEdit.font = [UIFont systemFontOfSize:12.0];
    [pwdView addSubview: _anquPwdEdit];
    
    //提交
    _anquCommit = [[UIButton alloc] initWithFrame:CGRectMake(20, 195, SCREENWIDTH - 40, 50)];
    [_anquCommit setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquCommit setTitle:@"提    交" forState:UIControlStateNormal];
    _anquCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_anquCommit addTarget:self action:@selector(anquResetClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquResetScrollView addSubview:_anquCommit];
    
    
//    if([AnquInterfaceKit getOrientation]!=UIInterfaceOrientationPortrait){ //横屏
//        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENHEIGHT,SCREENWIDTH)];
//        bgView.backgroundColor = [UIColor darkTextColor];
//        bgView.alpha = 0.5;
//        [self addSubview:bgView];
//        
//        _anquBindBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENHEIGHT/4 - 70, SCREENWIDTH/8, bg_width, bg_height)];
//        [self addSubview:_anquBindBgView];
//        
//        _anquBindBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
//        [_anquBindBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [_anquBindBgImageView setImage:[GetImage getRectImage:@"anqu_login_bg"]];
//        [_anquBindBgView addSubview:_anquBindBgImageView];
//        
//        //验证码
//        
//        //    UIImageView *userLogoImage=[[UIImageView alloc] initWithImage:[GetImage getSmallRectImage:@"anqu_login_user"]];
//        //    userLogoImage.frame = CGRectMake(50, 0, 25, 25);
//        //    _anquIdentEdit.leftView = userLogoImage;
//        //    _anquIdentEdit.leftViewMode = UITextFieldViewModeAlways;
//        
//    }
}

//倒计时
#pragma mark -Timer
-(void)timeFireMethod{
    resetbindSeconds--;
    NSString *tempStr = [NSString stringWithFormat:@"%d", resetbindSeconds];
    [_anquGetIdent setTitle:tempStr forState:UIControlStateNormal];
    if(resetbindSeconds==0){
        [_anquGetIdent setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_countDownTimer invalidate];
        [_anquGetIdent setUserInteractionEnabled:YES];
    }
}

-(void)anquCloseClick
{
   [self dismissModalViewControllerAnimated:YES];
}


-(void) anquValidUser:(id)sender{
    
     NSString *phone = _anquPhoneEdit.text;
    if ([phone length] == 0)
    {
        [UserData showMessage:@"手机号不能为空"];
        return;
    }
    else if ([phone length] != 11)
    {
        [UserData showMessage:@"请输入正确的手机号码"];
        return;
    }
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.labelText = @"请稍候...";
    _HUD.removeFromSuperViewOnHide = YES;
    [_HUD show: YES];
    
    _resetPost = [[httpRequest alloc] init];
    _resetPost.dlegate = self;
    _resetPost.success = @selector(check_callback:);
    _resetPost.error = @selector(get_error);
    NSLog(@"进入验证阶段");
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                phone,@"phone",nil];
    
    NSString *postData = [dictionary buildQueryString];
    
    NSLog(@"postData 检测手机存在=%@", [API_CHECKACCOUNT stringByAppendingFormat:@"%@", postData]);
    
    [_resetPost post:API_CHECKACCOUNT argData:postData];
}

//获取验证码
-(void)anquGetIdentClick
{
    NSString *phone = _anquPhoneEdit.text;

    resetidentCode = [BindPhone getIdentcode];
        
//        _HUD = [[MBProgressHUD alloc] initWithView:self];
//        [self addSubview:_HUD];
//        _HUD.removeFromSuperViewOnHide = YES;
//        [_HUD show: YES];
        
        _resetPost = [[httpRequest alloc] init];
        _resetPost.dlegate = self;
        _resetPost.success = @selector(get_callback:);
        _resetPost.error = @selector(get_error);
        

        NSString *sign = @"";
        NSString *mTime = [[AppInfo sharedSingleton] getData];
        
        sign = [sign stringByAppendingFormat:@"%@%@%@",phone,resetidentCode,signKey];
        NSLog(@"发送验证码Md5 sign = %@", [MyMD5 md5:sign]);
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [MyMD5 md5:sign], @"sign",
                                    phone,@"phone",
                                    resetidentCode, @"key"//用户名
                                    ,nil];
        
        NSString *postData = [dictionary buildQueryString];
        
        NSLog(@"postData modify=%@", [SEND_IDENT stringByAppendingFormat:@"%@", postData]);
        
        [_resetPost post:SEND_IDENT argData:postData];
    
        return;

}

-(void)check_callback:(NSString*)result{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *status = [rootDic objectForKey:@"status"];
    if([status intValue] == 0){
         [self anquGetIdentClick];
    }else{
//        [self showMessage:[rootDic objectForKey:@"msg"]];
//        if (_HUD != NULL) {
//            [_HUD hide:YES];
//        }
        [UserData showMessage:@"您未绑定手机，请使用网站找回密码。"];
        if (_HUD != NULL) {
            [_HUD hide:YES];
        }

        return;
        
    }

}

-(void)get_callback:(NSString*)tempResult
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    resetbindSeconds = 90;
    [_anquGetIdent setUserInteractionEnabled:NO];
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    return;
}

-(void)get_error
{
    [UserData showMessage:@"网络不给力"];
}

//提交
-(void)anquResetClick:(id)sender
{
    NSString *phoneText = _anquPhoneEdit.text;
    NSString *idenText = _anquIdentEdit.text;
    NSString *pwdText = _anquPwdEdit.text;
    
    if (phoneText.length == 0) {
        [UserData showMessage:@"手机号不能为空"];
        return;
    }else if(phoneText.length != 11){
        [UserData showMessage:@"手机号为11位"];
        return;
    }else if(idenText.length == 0){
        [UserData showMessage:@"验证码不能为空"];
        return;
    }else if(pwdText.length == 0){
        [UserData showMessage:@"密码不能为空"];
        return;
    }else{
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        //HUD.delegate = self;
        _HUD.removeFromSuperViewOnHide = YES;
        _HUD.dimBackground = YES;
        _HUD.labelText = @"正在重置,请稍候...";
        [_HUD show: YES];
        
        if(![resetidentCode isEqualToString:idenText]){  //验证码不对
            [UserData showMessage:@"输入的验证码不正确，请重新输入"];
            [_HUD hide: YES];
            return;
        }
        httpRequest *resetpost = [[httpRequest alloc] init];
        resetpost.dlegate = self;
        resetpost.success = @selector(reset_callback:);
        resetpost.error = @selector(reset_error);
        
        //NSString *sign = @"";
        //  NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
//        sign = [sign stringByAppendingFormat:@"%@%@%@",[AnquUser sharedSingleton].uid,phoneText,signKey];        
//        NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
        
        NSDictionary *resetdic = [NSDictionary dictionaryWithObjectsAndKeys:          //  [MyMD5 md5:sign], @"sign",
                                  phoneText, @"phone",
                                   pwdText, @"password", nil];
        
        NSString *resetData = [resetdic buildQueryString];
        
       // NSLog(@"resetData 验证码=%@，username=%@,pwd=%@", idenText,phoneText,pwdText);
        
        NSLog(@"resetData 重置=%@", [API_RESETPWD stringByAppendingFormat:@"%@", resetData]);
        
        [resetpost post:API_RESETPWD argData:resetData];
        
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
-(void)reset_callback:(NSString*)tempResult
{
    NSLog(@"重置返回结果=%@",tempResult);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:tempResult];
    NSString *status = [[rootDic objectForKey:@"status"] stringValue];
    
    NSLog(@"重置status = %@",status);
    if([status isEqualToString:@"0"]){
        NSLog(@"重置成功");
        [_HUD hide:YES];
        [UserData showMessage:@"客官，重置密码成功！"];
        
        // [self dismissModalViewControllerAnimated:YES];
       [self dismissModalViewControllerAnimated:YES];
    }else{
         [_HUD hide:YES];
        NSString *message = [rootDic objectForKey:@"msg"];
        [UserData showMessage:message];
        return;
        
    }
}

-(void)reset_error
{
    [UserData showMessage:@"连接超时"];
}

//-(void)showMessage:(NSString*)msg
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//}

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

