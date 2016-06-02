//
//  ForgetPass.m
//  AnquIOSSDK
//
//  Created by jiangfeng on 15/4/14.
//  Copyright (c) 2015年 anqu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForgetPass.h"
#import "Kefuconnect.h"


@interface ForgetPass ()

@end

@implementation ForgetPass

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
    
    _anquArray = [NSArray arrayWithObjects:@"手机找回", @"网站找回", nil];
    _anquImageArray = [NSArray arrayWithObjects:@"anqu_person_account", @"anqu_person_modify_pwd", nil];
    [self initPassHome];
    // Do any additional setup after loading the view.
}

-(void)initPassHome
{
   // _orientation = [UIApplication sharedApplication].statusBarOrientation;
    _orientation = [AnquInterfaceKit getOrientation];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anqupassBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _anquPayText.text = @"忘记密码";
    _anquPayText.font = [UIFont systemFontOfSize:20.0];
    _anquPayText.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(anquPassCustomClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 150, 65, 360, 20)];
    _anquTitle.text = UseRecPwdText; //未绑定手机号，请通过网站找回.
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_anquTitle];
    
//    _anquUserName = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 65, 60, 20)];
//    //_anquUserName.text = @"anqu_hero";
//    _anquUserName.text = [AnquUser sharedSingleton].username;
//    _anquUserName.font = [UIFont systemFontOfSize:12.0];
//    _anquUserName.textColor = [UIColor orangeColor];
//    [self.view addSubview:_anquUserName];
//    
//    _anquWel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 + 20, 65, 100, 20)];
//    _anquWel.font = [UIFont systemFontOfSize:12.0];
//    _anquWel.text = @"欢迎来到个人中心";
//    [self.view addSubview:_anquWel];
    
    UIImageView *anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10, 95, SCREENWIDTH - 20, 160)];
    [anquEditFrame setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
    anquEditFrame.userInteractionEnabled = YES;
    [self.view addSubview:anquEditFrame];
    
    _anquTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, SCREENWIDTH - 30, 150)];
    _anquTableView.delegate = self;
    _anquTableView.dataSource = self;
    //    _anquTableView.backgroundColor = [UIColor clearColor];
    
    //    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    imageview.contentMode = UIViewContentModeScaleToFill;
    //    [imageview setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
    //    [_anquTableView setBackgroundView:imageview];
    
    [anquEditFrame addSubview:_anquTableView];
    
}

-(void)popFinish:(id)sender{
    //    [_delegate anquLoginOutSuccess];
    //    [self dismissViewControllerAnimated:NO completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_anquArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AcountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AcountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.headImage.image = [GetImage imagesNamedFromCustomBundle:[_anquImageArray objectAtIndex:[indexPath row]]];
    cell.labelText.text = [_anquArray objectAtIndex:[indexPath row]];
    cell.tailImage.image = [GetImage imagesNamedFromCustomBundle:@"anqu_person_arrow"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 0:
        {
            
//                ResetPwd *reset = [[ResetPwd alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//                  [self.view addSubview:reset];
            ResetPwd *reset = [[ResetPwd alloc] init];
            [self presentModalViewController:reset animated:YES];
            
            
            //            [self presentModalViewController:bind animated:YES];

        }
            break;
            
        case 1:
        {
            _webForView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, SCREENHEIGHT - 55)];
            _webForView.scalesPageToFit =YES;
            _webForView.delegate =self;
            [self.view addSubview:_webForView];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:FORGETPWD_WEB]];
            [_webForView loadRequest:request];
//            AcountWeb *acount = [[AcountWeb alloc] init];
//            acount.payway = payway;
//            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
//            rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
//            [rootViewController presentModalViewController:acount animated:YES ];
  
            //            [self presentModalViewController:modifypwd animated:YES];
            //[self.view addSubview:modifypwd];
        }
            break;
            
        default:
        {
//            HumanResources *huMan = [[HumanResources alloc] init];
//            [self presentModalViewController:huMan animated:YES];
            
        }
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //    return cell.frame.size.height;
    return 50;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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

-(void)anquPassCustomClick
{
//    AcountWeb *web = [[AcountWeb alloc] init];
//    web.payway = 1;
//    [self presentModalViewController:web animated:YES];
    Kefuconnect *kefu = [[Kefuconnect alloc] init];
    [self presentModalViewController:kefu animated:YES];

    
}

-(void)anqupassBackClick:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
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
