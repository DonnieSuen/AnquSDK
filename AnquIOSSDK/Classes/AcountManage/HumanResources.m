//
//  HumanResources.m
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "HumanResources.h"
#import "Kefuconnect.h"
#import "Login.h"

@interface HumanResources ()

@end

@implementation HumanResources

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
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    [self initSafeHome];
    // Do any additional setup after loading the view.
}

-(void)initSafeHome
{
   // _orientation = [UIApplication sharedApplication].statusBarOrientation;
    _orientation = [AnquInterfaceKit getOrientation];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anquAcountBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _anquPayText.text = @"账号安全";
    _anquPayText.font = [UIFont systemFontOfSize:20.0];
    _anquPayText.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(humCustomClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    
#pragma mark -ScrollView
    _anquScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 56, SCREENWIDTH, SCREENHEIGHT - 60)];
    _anquScrollView.pagingEnabled = YES;
    _anquScrollView.delegate = self;
    _anquScrollView.showsVerticalScrollIndicator = NO;
    _anquScrollView.showsHorizontalScrollIndicator = NO;
    
    if (_orientation != UIDeviceOrientationPortrait)
    {//横竖屏button布局
        CGSize newSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 30);
        [_anquScrollView setContentSize:newSize];
    }
    else
    {
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50);
        [_anquScrollView setContentSize:newSize];
    }
    
    [self.view addSubview:_anquScrollView];
    
    UIView *headTitle = [[UIView alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 40)];
    [_anquScrollView addSubview:headTitle];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _anquTitle.text = @"尊敬的";
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    _anquTitle.backgroundColor = [UIColor clearColor];
    _anquTitle.textColor = [UIColor darkGrayColor];
    [headTitle addSubview:_anquTitle];
    
    _anquUserName = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 20)];
    _anquUserName.textColor = [UIColor orangeColor];
    _anquUserName.backgroundColor = [UIColor clearColor];
    _anquUserName.text = [AnquUser sharedSingleton].username;
    [headTitle addSubview:_anquUserName];
    
    _anquWel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH - 40, 20)];
    _anquWel.textColor = [UIColor darkGrayColor];
    _anquWel.backgroundColor = [UIColor clearColor];
    _anquWel.text = @"为了保障您的账号安全，请尽快完善您的资料";
    _anquWel.font = [UIFont systemFontOfSize:12.0];
    [headTitle addSubview:_anquWel];
    
#pragma mark -NAME
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, SCREENWIDTH - 40, 35)];
    [_anquScrollView addSubview:nameView];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    _anquTitle.text = @"真实姓名:";
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    _anquTitle.backgroundColor = [UIColor clearColor];
    _anquTitle.textColor = [UIColor darkGrayColor];
    [nameView addSubview:_anquTitle];
    
    _anquNameEt = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _anquNameEt.placeholder = @" 请输入您的姓名";
    _anquNameEt.delegate = self;
    _anquNameEt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquNameEt.font = [UIFont systemFontOfSize:12.0];
    _anquNameEt.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquNameEt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [nameView addSubview:_anquNameEt];
    
#pragma mark -SEX
    UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(20, 105, SCREENWIDTH - 40, 50)];
    [_anquScrollView addSubview:sexView];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 60, 20)];
    _anquTitle.text = @"性     别  :";
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    _anquTitle.backgroundColor = [UIColor clearColor];
    _anquTitle.textColor = [UIColor darkGrayColor];
    [sexView addSubview:_anquTitle];
    
    _anquMan = [[QCheckBox alloc] initWithDelegate:self];
    _anquMan.frame = CGRectMake(60, 0, 80, 50);
    _anquMan.tag = 1;
    [_anquMan setChecked:YES];
    [_anquMan setTitle:@"男" forState:UIControlStateNormal];
    [_anquMan setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_anquMan.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [sexView addSubview:_anquMan];
    
    _anquWoMan = [[QCheckBox alloc] initWithDelegate:self];
    _anquWoMan.frame = CGRectMake(140, 0, 80, 50);
    _anquWoMan.tag = 2;
    [_anquWoMan setChecked:YES];
    [_anquWoMan setTitle:@"女" forState:UIControlStateNormal];
    [_anquWoMan setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_anquWoMan.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [sexView addSubview:_anquWoMan];
    
    
    _anquSecret = [[QCheckBox alloc] initWithDelegate:self];
    _anquSecret.frame = CGRectMake(220, 0, 80, 50);
    _anquSecret.tag = 3;
    [_anquSecret setChecked:YES];
    [_anquSecret setTitle:@"保密" forState:UIControlStateNormal];
    [_anquSecret setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_anquSecret.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [sexView addSubview:_anquSecret];
    
    
#pragma mark -IdentNum
    UIView *identView = [[UIView alloc] initWithFrame:CGRectMake(20, 165, SCREENWIDTH - 40, 35)];
    [_anquScrollView addSubview:identView];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 60, 20)];
    _anquTitle.text = @"身 份 证  :";
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    _anquTitle.backgroundColor = [UIColor clearColor];
    _anquTitle.textColor = [UIColor darkGrayColor];
    [identView addSubview:_anquTitle];
    
    _anquIdentNumEt = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _anquIdentNumEt.placeholder = @" 请输入您的身份证号码";
    _anquIdentNumEt.delegate = self;
    _anquIdentNumEt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquIdentNumEt.font = [UIFont systemFontOfSize:12.0];
    _anquIdentNumEt.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquIdentNumEt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [identView addSubview:_anquIdentNumEt];
    
#pragma mark -QQ
    UIView *qqView = [[UIView alloc] initWithFrame:CGRectMake(20, 210, SCREENWIDTH - 40, 35)];
    [_anquScrollView addSubview:qqView];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 60, 20)];
    _anquTitle.text = @"您 的 QQ:";
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    _anquTitle.backgroundColor = [UIColor clearColor];
    _anquTitle.textColor = [UIColor darkGrayColor];
    [qqView addSubview:_anquTitle];
    
    _anquQQEt = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _anquQQEt.placeholder = @" 请输入您的QQ号";
    _anquQQEt.delegate = self;
    _anquQQEt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquQQEt.font = [UIFont systemFontOfSize:12.0];
    _anquQQEt.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquQQEt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [qqView addSubview:_anquQQEt];
    
    
    _anquEdit = [[UIButton alloc] initWithFrame:CGRectMake(20, 255, SCREENWIDTH - 40, 50)];
    [_anquEdit setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquEdit setTitle:@"提    交" forState:UIControlStateNormal];
    _anquEdit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_anquEdit addTarget:self action:@selector(anquinfoClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquScrollView addSubview:_anquEdit];
    
    
}

#pragma mark -VillApper
-(void)viewWillAppear:(BOOL)animated
{
    //获取用户信息
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走，正在获取信息中...";
    [_HUD show: YES];
    
    // 请求参数
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    NSString *partner = [dictionaryBundle objectForKey:@"cpuid"];
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
    
    NSString *deviceNo = [ActivateInfo sharedSingleton].deviceno;
    NSString *gameID = [AppInfo sharedSingleton].gameID;
    NSString *channelID = [AppInfo sharedSingleton].channelID;
    NSString *uid = [AnquUser sharedSingleton].uid;
    NSString *password = [AnquUser sharedSingleton].passwd;
    NSString *userName = [AnquUser sharedSingleton].username;
    NSString *appKey = [AppInfo sharedSingleton].gameKey;
    NSString *action = @"checkuserinfo";
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", gameID, deviceNo, channelID, partner, uid, userName, mTime, appKey];
    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:gameID, @"gameid",
                                deviceNo, @"deviceno",
                                channelID,@"referer",
                                partner, @"cpuid",
                                uid, @"uid",
                                userName, @"passport",//用户名
                                action, @"action",
                                mTime, @"time",
                                [MyMD5 md5:sign], @"sign",
                                @"1",@"debug", nil];
    NSString *postData = [dictionary buildQueryString];
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(get_user_callback:);
    _request.error = @selector(get_user_error);
    [_request post:GET_USER_INFO argData:postData];
}

-(void)anquAcountBackClick
{
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
//    Login *anquLogin = [[Login alloc] init];
//    [self  presentViewController:anquLogin animated:NO completion:^{NSLog(@"进入Login");}];
}

-(void)humCustomClick
{
    //[self dismissModalViewControllerAnimated:YES];
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    Kefuconnect *kefu = [[Kefuconnect alloc] init];
    [rootViewController presentModalViewController:kefu animated:YES];
    

}

-(void)get_user_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }

    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *code = [rootDic objectForKey:@"code"];
    NSDictionary *data = [rootDic objectForKey:@"data"];
    NSString *realname = [data objectForKey:@"realname"];
    NSString *idcard = [data objectForKey:@"idcard"];
    NSString *qq = [data objectForKey:@"qq"];
    
    _anquNameEt.text = realname;
    _anquQQEt.text = qq;
    _anquIdentNumEt.text = idcard;
}

-(void)get_user_error
{
    if (_HUD != NULL)
    {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


-(void)anquinfoClick:(id)sender
{
    //提交用户信息
    // 请求参数
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    NSString *partner = [dictionaryBundle objectForKey:@"cpuid"];
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
    
    NSString *deviceNo = [ActivateInfo sharedSingleton].deviceno;
    NSString *gameID = [AppInfo sharedSingleton].gameID;
    NSString *channelID = [AppInfo sharedSingleton].channelID;
    NSString *uid = [AnquUser sharedSingleton].uid;
    NSString *password = [AnquUser sharedSingleton].passwd;
    NSString *userName = [AnquUser sharedSingleton].username;
    NSString *appKey = [AppInfo sharedSingleton].gameKey;
    NSString *action = @"checkuserinfo";
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", gameID, deviceNo, channelID, partner, uid, userName, mTime, appKey];
    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:gameID, @"gameid",
                                deviceNo, @"deviceno",
                                channelID,@"referer",
                                partner, @"cpuid",
                                uid, @"uid",
                                userName, @"passport",//用户名
                                action, @"action",
                                mTime, @"time",
                                [MyMD5 md5:sign], @"sign",
                                [OrderInfo sharedSingleton].serverName, @"serverName",
                                _anquNameEt.text, @"realname",
                                _sexType, @"gendertype",
                                _anquIdentNumEt.text, @"idcard",
                                _anquQQEt.text, @"qq",
                                @"1",@"debug", nil];
    NSString *postData = [dictionary buildQueryString];
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(modify_user_callback:);
    _request.error = @selector(modify_user_error);
    [_request post:MODIFY_USER_INOF argData:postData];
}

//修改成功callback
-(void)modify_user_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *code = [rootDic objectForKey:@"code"];
    NSDictionary *data = [rootDic objectForKey:@"data"];
    NSString *realname = [data objectForKey:@"realname"];
    NSString *idcard = [data objectForKey:@"idcard"];
    NSString *qq = [data objectForKey:@"qq"];
}

-(void)modify_user_error
{
    if (_HUD != NULL)
    {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    
    if (_lastCheckBox) {//是否最后一次选中
        [_lastCheckBox setChecked:YES];
    }
    
    QCheckBox *chooseBox = checkbox;
//    [chooseBox setChecked:NO];
    _lastCheckBox = chooseBox;
    
    NSLog(@"%@",checked?@"YES":@"NO");
    
    switch (chooseBox.tag) {
        case 1://男
            _sexType = @"1";
            break;
            
        case 2://保密
            _sexType = @"2";
            break;
            
        default://女
            _sexType = @"0";
            break;
    }
}

-(void)yyPayBackClick:(id)sender{
        [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

#pragma -mark UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {//如果机型是iPhone
        
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
            offset = frame.origin.y + 200 - (self.view.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 180 - (self.view.frame.size.height -216.0);
        }
        
    }else{//机型是ipad
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
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



//iOS 6.0旋屏支持方向
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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
