//
//  Login.m
//

#import "Login.h"

@interface Login ()
{
   BOOL flag; //控制tabbar的显示与隐藏标志
}

@end

@implementation Login

int floatpositon = 0;
int ddLogLevel;

//单例模式
+ (RCDraggableButton *)shareInstance{
    static RCDraggableButton *flaotButton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIInterfaceOrientation orientationFloat = [UIApplication sharedApplication].statusBarOrientation;
        if (orientationFloat == UIInterfaceOrientationPortrait) {
            flaotButton=[[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, SCREENHEIGHT/2 - 30, 40, 40)];
        }else{
            flaotButton=[[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, SCREENWIDTH/2 - 30, 40, 40)];
        }
        
        [flaotButton setBackgroundImage:[GetImage imagesNamedFromCustomBundle:@"anqu_float_icon_normal"] forState:UIControlStateNormal];
    });
    //NSLog(@"悬浮%@",flaotButton);
    return flaotButton;
}

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
  //  _orientation = [UIApplication sharedApplication].statusBarOrientation;
    _orientation = [AnquInterfaceKit getOrientation];
    UIColor *mycolor =[UIColor colorWithWhite:0.5 alpha:0.7];
    self.view.backgroundColor =  mycolor;
    DDLogDebug(@"进入login 页面创建");
    
    [self initLoginView];
    ddLogLevel = [AnquInterfaceKit getLoggerLevel];
    // Do any additional setup after loading the view from its nib.
}

-(void)initLoginView
{
    
    DDLogDebug(@"_orientation==%d,横着=%ld,", _orientation,UIInterfaceOrientationIsLandscape( _orientation));
    DDLogDebug(@"SCREENHEIGHT==%fd,SCREENwidth==%fd",CGRectGetHeight([[UIScreen mainScreen] bounds]),CGRectGetWidth([[UIScreen mainScreen] bounds]));
    
    _anquRemPwd = [[QCheckBox alloc] initWithDelegate:self];
    
    if (_orientation == UIInterfaceOrientationUnknown) {
         DDLogDebug(@"方向未知屏");
        [self initPortraitLogin];
    }
    if (UIInterfaceOrientationIsLandscape(_orientation)  && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        DDLogDebug(@"横屏-login");
        [self initLandLogin];
        
    }else{
        DDLogDebug(@"竖屏-login");
        [self initPortraitLogin];
    }
    
         [_anquLoginBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
         [_anquLoginBgImageView setImage:[GetImage getRectImage:@"anqu_login_bg"]];
         [_anquLoginBgView addSubview:_anquLoginBgImageView];
         
         _anquTitle.textColor = UIColorFromRGB(0xFF6600);
         _anquTitle.textAlignment =  NSTextAlignmentCenter;
         _anquTitle.font = [UIFont systemFontOfSize:18.0];
         _anquTitle.text = UserLoginText;
         [_anquLoginBgView addSubview:_anquTitle];
    
         [_close setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
         [_close addTarget:self action:@selector(anquCloseLogin:) forControlEvents: UIControlEventTouchUpInside];//处理点击
         [_anquLoginBgView addSubview:_close];
    
         [_anquSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_split_line"]];
         [_anquLoginBgView addSubview:_anquSpliterLine];
    
         [_anquEditFrame setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
         [_anquLoginBgView addSubview:_anquEditFrame];
         
         //用户名
         _anquLoginUser.positionDelegate = self;
         _anquLoginUser.textField.delegate = self;
         //_yyNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
         [_anquLoginBgView addSubview:_anquLoginUser];
    
         [_inputSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_split_line"]];
         [_anquLoginBgView addSubview:_inputSpliterLine];
         
         //密码
         UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 50)];
         UIImageView *passwdLogoImage=[[UIImageView alloc] initWithImage:[GetImage imagesNamedFromCustomBundle:@"anqu_input_pwd"]];
         passwdLogoImage.frame = CGRectMake(7, 12, 25, 25);
         [leftview addSubview:passwdLogoImage];
         _anquLoginPwd.leftView = leftview;
         _anquLoginPwd.leftViewMode = UITextFieldViewModeAlways;
         _anquLoginPwd.placeholder = @" 请输入密码";
         _anquLoginPwd.delegate = self;
         [_anquLoginPwd setSecureTextEntry:TRUE];
         _anquLoginPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
         _anquLoginPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
         [_anquLoginBgView addSubview:_anquLoginPwd];
    
         [_anquRemPwd setTitle:@"记住密码" forState:UIControlStateNormal];
         [_anquRemPwd setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         [_anquRemPwd.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
         [_anquLoginBgView addSubview:_anquRemPwd];
    
         _anquForgetPwd.text = @"个人中心";
         _anquForgetPwd.userInteractionEnabled = YES;
         UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgetPwdEvent:)];
         [_anquForgetPwd addGestureRecognizer:tapGestureTel];
         _anquForgetPwd.backgroundColor = [UIColor clearColor];
         _anquForgetPwd.font = [UIFont systemFontOfSize:12.0];
         _anquForgetPwd.textColor = [UIColor blueColor];
         [_anquLoginBgView addSubview:_anquForgetPwd];
         
         //一键注册
         [_anquRegisterBt setBackgroundImage:[GetImage getSmallRectImage:@"anqu_register_bt"] forState:UIControlStateNormal];
         [_anquRegisterBt setTitle:@"注册" forState:UIControlStateNormal];
         _anquRegisterBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
         [_anquRegisterBt addTarget:self action:@selector(anquClickRegister:) forControlEvents: UIControlEventTouchUpInside];//处理点击
         [_anquLoginBgView addSubview:_anquRegisterBt];
         
         //立即登陆
         [_anquLoginBt setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
         [_anquLoginBt setTitle:@"进入游戏" forState:UIControlStateNormal];
         _anquLoginBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
         [_anquLoginBt addTarget:self action:@selector(anquLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
         [_anquLoginBgView addSubview:_anquLoginBt];
    
}

-(void) initLandLogin{
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);

    _anquLoginBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,max,min)];
    [self.view addSubview:_anquLoginBgView];
    
    _anquLoginBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,max,min)];
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(max/3, 25, max/3, 25)];
    _close = [[UIButton alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+max - 50, 15, 50, 50)];
    _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+14, 60, max-30, 1)];
    _anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+max/6, 70, max*2/3, 100)];
    _anquLoginUser = [[DropListView alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+max/6, 70, max*2/3, 50)];
    _inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+max/6, 120, max*2/3, 1)];
    _anquLoginPwd = [[UITextField alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+max/6, 120, max*5/6-20, 50)];
    _anquForgetPwd = [[UILabel alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+max*2/3, 180, max/6, 50)];
    _anquRegisterBt = [[UIButton alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+max/6, 230, max/4, 35)];
    _anquLoginBt = [[UIButton alloc] initWithFrame:CGRectMake(_anquLoginBgImageView.frame.origin.x+max*2/3-30, 230, max/4, 35)];
    _anquRemPwd.frame = CGRectMake(_anquLoginBgImageView.frame.origin.x+max/6, 180, 80, 50);
}

-(void) initPortraitLogin{
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    
    _anquLoginBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,min,min)];
    [self.view addSubview:_anquLoginBgView];
    _anquLoginBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,min,min)];
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(min/3, 25, min/3, 25)];
    _close = [[UIButton alloc] initWithFrame:CGRectMake(min - 50, 15, 45, 45)];
    _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, min-30, 1)];
    _anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(min/6, 70, min*2/3, 100)];
    _anquLoginUser = [[DropListView alloc] initWithFrame:CGRectMake(min/6, 70, min*2/3, 50)];
    _inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(min/6, 120, min*2/3, 1)];
    _anquLoginPwd = [[UITextField alloc] initWithFrame:CGRectMake(min/6, 120, min*5/6-20, 50)];
    _anquForgetPwd = [[UILabel alloc] initWithFrame:CGRectMake(min*2/3, 180, min/6, 50)];
    _anquRegisterBt = [[UIButton alloc] initWithFrame:CGRectMake(min/6, 230, min/4, 35)];
    _anquLoginBt = [[UIButton alloc] initWithFrame:CGRectMake(min*2/3-30, 230, min/4, 35)];
    _anquRemPwd.frame = CGRectMake(min/6, 180, 80, 50);
}

//忘记密码处理  1.绑定手机号则直接获取验证码进行密码重置；2.未绑定则转到重置密码的页面
-(void)forgetPwdEvent:(id)sender
{
    DDLogDebug(@"忘记密码，进入个人中心");
    [self performSelectorOnMainThread:@selector(enterAccountCenter) withObject:nil waitUntilDone:NO];
    
//    AcountWeb *acount = [[AcountWeb alloc] init];
//    acount.payway = 0;
//    [self presentModalViewController:acount animated:YES];
}

-(void)enterAccountCenter{
    AcountHome *acount = [[AcountHome alloc] init];
    acount.delegate = _delegate;
    //其实没用
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:acount animated:YES completion:^{
        
    }];
 //     [self presentModalViewController:acount animated:YES];
      [self  presentViewController:acount animated:NO completion:^{NSLog(@"进入个人中心");}];
}

-(void)anquClickRegister:(id)sender
{

  Register *anquRegister = [[Register alloc] init];
  [self  presentViewController:anquRegister animated:NO completion:^{
            NSLog(@"进入注册");
          [self removeFromParentViewController];
        }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"关闭登录");
//        [self dismissViewControllerAnimated:YES completion:nil];
//    });

}

-(void)anquCloseLogin:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"login关闭");}];
    //[self dismissModalViewControllerAnimated:YES];
    
   // [self removeFromParentViewController];
    
}

//注册成功callback
-(void)back
{
   //[_delegate AnquLoginOnSuccess:[AnquUser sharedSingleton]];
    [_delegate AnquLoginOn:AnquLoginOnSuccess];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
//    [self performSelectorOnMainThread:@selector(loadAvatarInKeyWindow) withObject:nil waitUntilDone:NO];
   // [self presentViewController:_delegate animated:NO completion:^{NSLog(@"登陆成功");}];
   // [self dismissModalViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        DDLogDebug(@"登陆成功，_isshowDraggle＝%ld",_isshowDraggle);
        if (_isshowDraggle == TRUE) {
            [self loadAvatarInKeyWindow];
        }
        
    }];
}

-(void)anquLoginClick:(id)sender
{
//    [self loadAvatarInKeyWindow];
//    [self _initTabBar];//注释掉
    
    if (_anquLoginUser.textField.text.length < 5|| _anquLoginUser.textField.text.length > 36) {
        [UserData showMessage:@"用户名输入错误(5-36个字符)"];
        return;
    }
    if (_anquLoginPwd.text.length < 5) {
        [UserData showMessage:@"密码输入错误(5-36个字符)"];
        return;
    }
    if(![checkWifi connectedToNetWork]){//|| ![checkWifi IsEnable3G] || ![checkWifi IsEnableWIFI]
        [UserData showMessage:@"网络连接错误，请检查网络是否正常"];
        return;
    }
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走，玩命登陆中...";
    [_HUD show: YES];
    
    _passport = _anquLoginUser.textField.text;
    
    // 登录请求   sessiond用来跟服务器验证
//  sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID, [ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].channelID, partner, _passport, _anquLoginPwd.text, mTime, [AppInfo sharedSingleton].gameKey];
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AppInfo sharedSingleton].gameID, @"gameid",[ActivateInfo sharedSingleton].deviceno, @"deviceno",
//   mTime, @"time", @"1",@"debug",[MyMD5 md5:sign], @"sign",nil];
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    
    sign = [sign stringByAppendingFormat:@"%@%@%@", _passport, _anquLoginPwd.text,signKey];

    DDLogDebug(@"Md5 sign = %@,channel is %@", [MyMD5 md5:sign],[AppInfo sharedSingleton].channelID);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:_passport, @"username",
                                _anquLoginPwd.text, @"password",
                                [AppInfo sharedSingleton].channelID,@"channel",
                                [AppInfo sharedSingleton].gameID, @"appid",
                                [MyMD5 md5:sign], @"sign",nil];
    
    NSString *postData = [dictionary buildQueryString];
    DDLogDebug(@"postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(login_callback:);
    _request.error = @selector(login_error);
    [_request post:API_URL_LOGIN argData:postData];
}

-(void)login_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }

    [UserData push:_anquLoginUser.textField.text password:_anquLoginPwd.text]; //密文保存
    
    DDLogDebug(@"Anqu login info result = %@", result);//登录信息
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *status = [rootDic objectForKey:@"status"];
    NSString *message = [rootDic objectForKey:@"msg"];
    if([status intValue] == 0){
        NSString *uid = [rootDic objectForKey:@"uid"];
        NSString *vkey = [rootDic objectForKey:@"vkey"];
        [AnquUser sharedSingleton].uid = uid;
        [AnquUser sharedSingleton].sessiond = vkey;
        [AnquUser sharedSingleton].username =_anquLoginUser.textField.text;
      
        //[AnquUser sharedSingleton].passwd =_anquLoginPwd.text;
        
        //登录成功，callback
        [self back];
        
        //[[AnquUser sharedSingleton] initWithType:_passport Pwd:_anquLoginPwd.text Sessiond:vkey Uid:uid];
        
    }else
    {
        [UserData showMessage:message]; //提示框
       
        [_delegate AnquLoginOn:AnquLoginOnFail];
        
        return;
    }
}

-(void)login_error{
    if (_HUD != NULL)
    {
        [_HUD hide:YES];
    }
    
    [UserData showMessage:@"网络不给力"];
    [_delegate AnquLoginOn:AnquNoLoginOn];
}

#pragma mark -VillApper
-(void)viewWillAppear:(BOOL)animated{
//    [self loadAvatarInKeyWindow];
//    [self _initTabBar];
    
    _UserArray = [[NSMutableArray alloc] init];
    _PasswordArray = [[NSMutableArray alloc] init];
    
    NSDictionary *queryResult = [UserData get];
    NSEnumerator *enumeratorKey = [queryResult keyEnumerator];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    
    //遍历所有key
    for (NSString *object in enumeratorKey){
        NSDictionary *userInfo = [[UserData get] objectForKey:object];
        //字典
        [result addObject:userInfo];
    }
    
    NSArray *newResult =
    [result sortedArrayUsingComparator:^(id obj1,id obj2)
     {
         NSDictionary *dic1 = (NSDictionary *)obj1;
         NSDictionary *dic2 = (NSDictionary *)obj2;
         NSNumber *num1 = (NSNumber *)[dic1 objectForKey:@"last_date"];
         NSNumber *num2 = (NSNumber *)[dic2 objectForKey:@"last_date"];
         if ([num1 floatValue] > [num2 floatValue])
         {
             return (NSComparisonResult)NSOrderedAscending;
         }
         else
         {
             return (NSComparisonResult)NSOrderedDescending;
         }
         return (NSComparisonResult)NSOrderedSame;
     }];
    
    for (id user in newResult){
        //字典
        [_UserArray addObject:[user objectForKey:@"username"]];
        [_PasswordArray addObject:[user objectForKey:@"password"]];
    }
    
    if ([_UserArray count] != 0) {
        _anquLoginUser.textField.text = [_UserArray objectAtIndex:0];
        _anquLoginPwd.text = [_PasswordArray objectAtIndex:0];
        _anquLoginUser.tableArray = _UserArray;
    }
    
}

/**
 *  设置选择相应的position
 *
 *  @param position 选择的position位置
 */
-(void)setPasswdText:(NSInteger)position{
    
    if ([_UserArray count] != 0) {
        DDLogDebug(@"passwd = %@",[_PasswordArray objectAtIndex:position]);
        _anquLoginPwd.text = [_PasswordArray objectAtIndex:position];
    }
}

-(void)setCleanIndex:(NSInteger)position{
    
    if (0 != [_UserArray count]) {
        //移除
        [UserData pop:[_UserArray objectAtIndex:position]];
        
        NSDictionary *queryResult = [UserData get];
        NSEnumerator *enumeratorKey = [queryResult keyEnumerator];
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
        
        //遍历所有key
        for (NSString *object in enumeratorKey){
            NSDictionary *userInfo = [[UserData get] objectForKey:object];
            //字典
            [result addObject:userInfo];
        }
        
        NSArray *newResult =
        [result sortedArrayUsingComparator:^(id obj1,id obj2)
         {
             NSDictionary *dic1 = (NSDictionary *)obj1;
             NSDictionary *dic2 = (NSDictionary *)obj2;
             NSNumber *num1 = (NSNumber *)[dic1 objectForKey:@"last_date"];
             NSNumber *num2 = (NSNumber *)[dic2 objectForKey:@"last_date"];
             if ([num1 floatValue] > [num2 floatValue])
             {
                 return (NSComparisonResult)NSOrderedAscending;
             }
             else
             {
                 return (NSComparisonResult)NSOrderedDescending;
             }
             return (NSComparisonResult)NSOrderedSame;
         }];
        
        NSMutableArray *newUserArray = [[NSMutableArray alloc] init];
        NSMutableArray *newPasswdArray = [[NSMutableArray alloc] init];
        
        for (id user in newResult){
            //字典
            [newUserArray addObject:[user objectForKey:@"username"]];
            [newPasswdArray addObject:[user objectForKey:@"password"]];
        }
        
        _UserArray = newUserArray;
        _PasswordArray = newPasswdArray;
        _anquLoginUser.tableArray = _UserArray;
    }
}


#pragma -mark UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {//如果机型是iPhone
       
        if (UIInterfaceOrientationIsPortrait( _orientation)) {//是竖屏
            offset = frame.origin.y + 200 - (self.view.frame.size.height -216.0);
            DDLogDebug(@"这里竖屏offset==%d",offset);
        }else{
            offset = frame.origin.y + 160 - (self.view.frame.size.height -216.0);
              DDLogDebug(@"这里横屏offset==%d",offset);
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
            self.view.frame =CGRectMake(offset/4, 0.0f,self.view.frame.size.width,self.view.frame.size.height);//-offset 0.0f
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

//悬浮图标
- (void)loadAvatarInKeyWindow {
    RCDraggableButton *avatar = [Login shareInstance];
  
    DDLogDebug(@"l进入tabbar设置,%d",(!flag));
    [avatar setTapBlock:^(RCDraggableButton *avatar) {
        if(!flag){
            [self _initTabBar];
            _tabBarView.hidden = NO;
            _fullbgView.hidden = NO;
            flag = YES;
        }else{
            DDLogDebug(@"进入隐藏tabbar设置");
            _tabBarView.hidden = YES;
            _fullbgView.hidden = YES;
            flag = NO;
        }
    }];
    
    [avatar setDraggingBlock:^(RCDraggableButton *avatar) {
        _tabBarView.hidden = YES;
        _fullbgView.hidden = YES;
    }];
    
    [avatar setDragDoneBlock:^(RCDraggableButton *avatar) {
        _tabBarView.hidden = YES;
        _fullbgView.hidden = YES;
    }];
    
    [avatar setAutoDockingBlock:^(RCDraggableButton *avatar) {
        _tabBarView.hidden = YES;
        _fullbgView.hidden = YES;
    }];
    
    [avatar setAutoDockingDoneBlock:^(RCDraggableButton *avatar) {
        _tabBarView.hidden = YES;
        _fullbgView.hidden = YES;
    }];
}

//初始化tabbar
-(void)_initTabBar
{
    DDLogDebug(@"进入inittab Bar");
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
    _fullbgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, max, min)];
    
    //    _fullbgView.backgroundColor = [UIColor darkGrayColor];
    //    _fullbgView.alpha = 0.5;
    
    _floatWindow = [UIApplication sharedApplication].keyWindow;
    if (!_floatWindow)
        _floatWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [[[_floatWindow subviews] objectAtIndex:0] addSubview:_fullbgView];
    
    [_fullbgView setHidden:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tapButton:)];
    [_fullbgView addGestureRecognizer:singleTap];
    
    CGFloat originX = [Login shareInstance].frame.origin.x;
    CGFloat originY = [Login shareInstance].frame.origin.y;
    
    if ([Login shareInstance].frame.origin.x != 0.00000)
    {
        _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(originX - 180, originY, 90, 40)];//180
        _tabBarView.image = [GetImage getFloatRectImage:@"anqu_float_r_bg"];
    }
    else
    {
        _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(originX + 40, originY, 90, 40)];//180
        _tabBarView.image = [GetImage getFloatRectImage:@"anqu_float_l_bg"];
    }
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.contentMode = UIViewContentModeScaleToFill;
    //    _tabBarView.backgroundColor = [UIColor darkGrayColor];
    //    _tabBarView.alpha = 0.2f;//设置透明
    //    _tabBarView.layer.masksToBounds = YES;
    [_fullbgView addSubview:_tabBarView];

   
//    //循环设置tabbar上的button
      NSArray *imgNames = [[NSArray alloc]initWithObjects:@"anqu_float_help_normal",@"anqu_float_account_normal", nil];
//    NSArray *imgContent = @[@"游戏论坛",@"活动",@"客服",@"用户中心"];
//    
    for (int i=0; i<2; i++) {
        CGRect rect;
        rect.size.width = 30;
        rect.size.height = 30;
        
        switch (i) {
            case 0:
                rect.origin.x = 10;
                rect.origin.y = 5;
                break;
            case 1:
                rect.origin.x = 45;
                rect.origin.y = 5;
                break;
            case 2:
                rect.origin.x = 85;
                rect.origin.y = 5;
                break;
            case 3:
                rect.origin.x = 125;
                rect.origin.y = 5;
                break;
        }
        
        //设置每个tabView
//        UIView *tabView = [[UIView alloc] initWithFrame:rect];
//        [_tabBarView addSubview:tabView];
        
        //设置tabView的图标
        UIButton *tabButton = [[UIButton alloc] initWithFrame:rect];
        [tabButton setBackgroundImage:[GetImage imagesNamedFromCustomBundle:[imgNames objectAtIndex:i]] forState:UIControlStateNormal];
        [tabButton setContentMode:UIViewContentModeScaleToFill];
        [tabButton setTag:i];
        [tabButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:tabButton];
        //NSLog(@"点击view_tabBarView=%@,tabbutton=%@",_tabBarView,tabButton);
    }
    

    [_tabBarView setHidden:NO];
}

#pragma mark -Float
- (void)buttonClicked:(id)sender
{
   // NSLog(@"buttonClicked=%ld",(long)[sender tag]);
    NSInteger butttag = [(UIButton*)sender tag];
    _tabBarView.hidden = YES;
    _fullbgView.hidden = YES;
    [Login shareInstance].hidden = NO;
    
    if (butttag == 0) {//客服
        [[AnquInterfaceKit sharedInstance] suspendView:1];
        
    }else if (butttag == 1){ //个人中心
        floatpositon = 3;
        [[AnquInterfaceKit sharedInstance] suspendView:2];
        
    }
//    else if (butttag == 2){
//        floatpositon = 1;
//        [[AnquInterfaceKit sharedInstance] suspendView:1];
//        
//    }else if (butttag == 3){
//        floatpositon = 0;
//        [[AnquInterfaceKit sharedInstance] suspendView:4];
//    }
}

-(void)tapButton:(id)sender{
    _fullbgView.hidden = YES;
    _tabBarView.hidden = YES;
    [Login shareInstance].hidden = NO;
}

#pragma mark - QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    DDLogDebug(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
}

//0旋屏支持方向
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}
//
//- (BOOL)shouldAutorotate
//{
//    
//    return YES;
//    
//}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
