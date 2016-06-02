//
//  ModifyPwd.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "ModifyPwd.h"

@interface ModifyPwd ()

@end

@implementation ModifyPwd

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
    
   // _orientation = [UIApplication sharedApplication].statusBarOrientation;
    _orientation = [AnquInterfaceKit getOrientation];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    [self initModifyView];
    // Do any additional setup after loading the view.
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        self.userInteractionEnabled = YES;
//        [self initModifyView];
//    }
//    return self;
//}
-(void)viewWillAppear:(BOOL)animated
{
}

-(void)initModifyView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//    bgView.backgroundColor = [UIColor darkTextColor];
//    bgView.alpha = 0.5;
//    [self addSubview:bgView];
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _modback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_modback setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_modback addTarget:self action:@selector(anquCloseClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_modback];
    
//    _anquModifyBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
//    [self addSubview:_anquModifyBgView];
    
    UILabel *anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80,
                                                                   50)];
    anquTitle.textColor = UIColorFromRGB(0xFF6600);
    anquTitle.font = [UIFont systemFontOfSize:15.0];
    anquTitle.text = @"修改密码";
    [self.view addSubview:anquTitle];
    
    _close = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(anquCloseClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
     [self.view addSubview:_close];
    
    _anquSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSpliterLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSpliterLine];
    
    _anquModScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 56, SCREENWIDTH, SCREENHEIGHT - 60)];
    _anquModScrollView.pagingEnabled = YES;
    _anquModScrollView.delegate = self;
    _anquModScrollView.showsVerticalScrollIndicator = NO;
    _anquModScrollView.showsHorizontalScrollIndicator = NO;
    
    if (_orientation != UIDeviceOrientationPortrait)
    {//横屏button布局
        CGSize newSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 30);
        [_anquModScrollView setContentSize:newSize];
    }
    else
    {
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50);
        [_anquModScrollView setContentSize:newSize];
    }
    
    [self.view addSubview:_anquModScrollView];
    
    
    UIView *oldpwdView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, SCREENWIDTH - 40, 35)];
    [_anquModScrollView addSubview:oldpwdView];
    
    _anqupwdO = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    _anqupwdO.text = @"旧密码:";
    _anqupwdO.font = [UIFont systemFontOfSize:12.0];
    _anqupwdO.backgroundColor = [UIColor clearColor];
    _anqupwdO.textColor = [UIColor darkGrayColor];
    [oldpwdView addSubview:_anqupwdO];
    
    //旧密码
    _anquOldPwd = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _anquOldPwd.placeholder = @" 请输入旧的账号密码";
    _anquOldPwd.delegate = self;
    _anquOldPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquOldPwd.font = [UIFont systemFontOfSize:12.0];
    _anquOldPwd.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquOldPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _anquOldPwd.returnKeyType= UIReturnKeyDone;
    [oldpwdView addSubview:_anquOldPwd];

    
    UIView *newpwdView = [[UIView alloc] initWithFrame:CGRectMake(20, 70, SCREENWIDTH - 40, 35)];
    [_anquModScrollView addSubview:newpwdView];
    
    _anqupwdN = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    _anqupwdN.text = @"新密码:";
    _anqupwdN.font = [UIFont systemFontOfSize:12.0];
    _anqupwdN.backgroundColor = [UIColor clearColor];
    _anqupwdN.textColor = [UIColor darkGrayColor];
    [newpwdView addSubview:_anqupwdN];
    
      //新密码
    _anquNewPwd = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _anquNewPwd.placeholder = @" 密码:6-20位字母、数字、下划线“_”";
    _anquNewPwd.delegate = self;
    _anquNewPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquNewPwd.font = [UIFont systemFontOfSize:12.0];
    _anquNewPwd.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquNewPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _anquNewPwd.returnKeyType= UIReturnKeyDone;
    [newpwdView addSubview:_anquNewPwd];
    
 
    //重复密码
    UIView *repeatView = [[UIView alloc] initWithFrame:CGRectMake(20, 120, SCREENWIDTH - 40, 35)];
    [_anquModScrollView addSubview:repeatView];
    
    _anqupwdRe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    _anqupwdRe.text = @"确认密码:";
    _anqupwdRe.font = [UIFont systemFontOfSize:12.0];
    _anqupwdRe.backgroundColor = [UIColor clearColor];
    _anqupwdRe.textColor = [UIColor darkGrayColor];
    [repeatView addSubview:_anqupwdRe];
    
    //新密码
    _anquRepeatPwd = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _anquRepeatPwd.placeholder = @" 再输入一遍新密码";
    _anquRepeatPwd.delegate = self;
    _anquRepeatPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _anquRepeatPwd.font = [UIFont systemFontOfSize:12.0];
    _anquRepeatPwd.background = [GetImage getSmallRectImage:@"anqu_cash_input"];
    _anquRepeatPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _anquRepeatPwd.returnKeyType= UIReturnKeyDone;
    [repeatView addSubview:_anquRepeatPwd];

    
    //提交
    _anquModifyBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 180, SCREENWIDTH - 40, 50)];
    [_anquModifyBt setBackgroundImage:[GetImage getSmallRectImage:@"anqu_login_bt"] forState:UIControlStateNormal];
    [_anquModifyBt setTitle:@"提交修改" forState:UIControlStateNormal];
    _anquModifyBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_anquModifyBt addTarget:self action:@selector(anquModifyClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_anquModScrollView addSubview:_anquModifyBt];

}

-(void)anquModifyClick:(id)sender
{
    NSString *oldPwd = _anquOldPwd.text;
    NSString *newPwd = _anquNewPwd.text;
    NSString *rePwd = _anquRepeatPwd.text;
    
    if ([oldPwd length] == 0) {
        [UserData showMessage:@"请输入原来密码"];
        return;
    }
    
    if ([newPwd length] == 0 || [newPwd length] < 6) {
        [UserData showMessage:@"您的密码不符合要求"];
        return;
    }
    
    if (![newPwd isEqualToString:rePwd]) {
        [UserData showMessage:@"两次输入密码不一致"];
        return;
    }
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"加载中，请稍后...";
    [_HUD show: YES];
    
    _aliPost = [[httpRequest alloc] init];
    _aliPost.dlegate = self;
    _aliPost.success = @selector(modify_callback:);
    _aliPost.error = @selector(modify_error);
    
    // 登录请求
//    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
//    NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
    NSString *sign = @"";
    //NSString *mTime = [[AppInfo sharedSingleton] getData];
    NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@",[AnquUser sharedSingleton].uid,oldPwd, newPwd,signKey];
    
    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                [AnquUser sharedSingleton].uid, @"uid",
//                                @"1",@"debug",
//                                [OrderInfo sharedSingleton].serverName, @"serverName",//游戏服名
//                                [AppInfo sharedSingleton].gameID, @"gameid",
//                                [MyMD5 md5:sign], @"sign",
//                                mTime, @"time",
//                                [ActivateInfo sharedSingleton].deviceno, @"deviceno",
//                                partner, @"cpuid",
//                                [AppInfo sharedSingleton].channelID,@"referer",
//                                [AnquUser sharedSingleton].username, @"passport",//用户名
//                                oldPwd, @"oldp",//充值角色
//                                newPwd, @"newp",nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [AnquUser sharedSingleton].uid, @"uid",
                                [MyMD5 md5:sign], @"sign",
                                [AnquUser sharedSingleton].username, @"username",//用户名
                                oldPwd, @"oldp",//旧密码
                                newPwd, @"newp",nil];

    
    NSString *postData = [dictionary buildQueryString];
    
    DDLogDebug(@"postData modify=%@", [MODIFY_PWD stringByAppendingFormat:@"%@", postData]);
    
    [_aliPost post:MODIFY_PWD argData:postData];

}

-(void)modify_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    DDLogDebug(@"修改密码 result = %@", result);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *status = [rootDic objectForKey:@"status"];
    
    if ([status intValue] == 0)
    {
        [UserData showMessage:@"密码修改成功。"];
        //[self dismissModalViewControllerAnimated:YES];//修改成功callback
        //[self removeFromSuperview];
    }
    else
    {
        [UserData showMessage:[rootDic objectForKey:@"msg"]];
    }
}

-(void)modify_error
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    [UserData showMessage:@"网络连接超时"];
}

-(void)anquCloseClick
{
    [self dismissModalViewControllerAnimated:YES];
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


//
//#pragma -mark UITextField Delegate
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    CGRect frame = textField.frame;
//    int offset;
//
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {//如果机型是iPhone
//
//        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
//            offset = frame.origin.y + 200 - (self.frame.size.height -216.0);
//        }else{
//            offset = frame.origin.y + 180 - (self.frame.size.height -216.0);
//        }
//
//    }else{//机型是ipad
//        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
//            offset = frame.origin.y + 100 - (self.frame.size.height -216.0);
//        }else{
//            offset = frame.origin.y + 190 - (self.frame.size.height -216.0);
//        }
//
//    }
//
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard"context:nil];
//    [UIView setAnimationDuration:animationDuration];
//
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
//            self.frame =CGRectMake(0.0f, -offset,self.frame.size.width,self.frame.size.height);//-offset 0.0f
//        }else{
//            self.frame =CGRectMake(offset, 0.0f,self.frame.size.width,self.frame.size.height);//-offset 0.0f
//        }
//
//    [UIView commitAnimations];
//
//}
//
////当用户按下return键或者按回车键，keyboard消失
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//
////输入框编辑完成以后，将视图恢复到原始状态
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    self.frame =CGRectMake(0,0, self.frame.size.width,self.frame.size.height);
//}
//
////触摸view隐藏键盘——touchDown
//
//- (IBAction)View_TouchDown:(id)sender {
//    // 发送resignFirstResponder.
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
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
