//
//  AcountHome.m
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "AcountHome.h"
#import "Kefuconnect.h"
#import "Login.h"

@interface AcountHome ()

@end

@implementation AcountHome

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popFinishAct:) name:@"LoginOut_close" object:nil];
    
    _anquArray = [NSArray arrayWithObjects:@"账号安全", @"客服中心", @"忘记密码", @"注销账号",nil];
    _anquImageArray = [NSArray arrayWithObjects:@"anqu_person_account", @"anqu_person_costum",  @"anqu_person_announcementspage", @"anqu_person_logout", nil];
    [self initAcountHome];
    // Do any additional setup after loading the view.
}

-(void)initAcountHome
{
    //_orientation = [UIApplication sharedApplication].statusBarOrientation;
    _orientation= [AnquInterfaceKit getOrientation];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anquAccountBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _anquPayText.text = @"用户中心";
    _anquPayText.font = [UIFont systemFontOfSize:20.0];
    _anquPayText.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(anquAcountCustomClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 65, 40, 20)];
    _anquTitle.text = @"尊敬的:";
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_anquTitle];
    
    _anquUserName = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 65, 100, 20)];
   // _anquUserName.text = [AnquUser sharedSingleton].username;
    _anquUserName.text = UserCenterTitle;
    _anquUserName.font = [UIFont systemFontOfSize:12.0];
    _anquUserName.textColor = [UIColor orangeColor];
    [self.view addSubview:_anquUserName];
    
    _anquWel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 + 60, 65, 100, 20)];
    _anquWel.font = [UIFont systemFontOfSize:12.0];
    _anquWel.text = @"欢迎来到用户中心";
    [self.view addSubview:_anquWel];
    
    UIImageView *anquEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10, 95, SCREENWIDTH - 20, 210)];
    [anquEditFrame setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
    anquEditFrame.userInteractionEnabled = YES;
    [self.view addSubview:anquEditFrame];
    
    _anquTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, SCREENWIDTH - 30, 200)];
    _anquTableView.delegate = self;
    _anquTableView.dataSource = self;
    _anquTableView.backgroundColor = [UIColor clearColor];
    
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageview.contentMode = UIViewContentModeScaleToFill;
//    [imageview setImage:[GetImage getSmallRectImage:@"anqu_input_edit"]];
//    [_anquTableView setBackgroundView:imageview];

    [anquEditFrame addSubview:_anquTableView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)popFinishAct:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [_delegate AnquLoginOut:AnquLogoutSuccess];//注销回调
}

 //隐藏视图
-(void)anquAccountBackClick
{
  
//    NSString *uid = [[AnquUser sharedSingleton] uid];
//    if([uid length]==0){
//        Login *anquLogin = [[Login alloc] init];
//        [self  presentViewController:anquLogin animated:NO completion:^{NSLog(@"进入Login");}];
//    }else{
//           [self dismissViewControllerAnimated:NO completion:nil];
//    }
    CGFloat max = MAX(SCREENHEIGHT, SCREENWIDTH);
    CGFloat min = MIN(SCREENHEIGHT, SCREENWIDTH);
    self.view.frame = CGRectMake(0, 0, min, max);
    
 // [self dismissViewControllerAnimated:NO completion:nil];
    
    [self dismissModalViewControllerAnimated:YES];


 }



//客服第一版暂不支持  充值渠道为2
-(void)anquAcountCustomClick
{
//    AcountWeb *web = [[AcountWeb alloc] init];
//    web.payway = 2;
//    [self presentModalViewController:web animated:YES];
    
    Kefuconnect *kefu = [[Kefuconnect alloc] init];
   [self presentModalViewController:kefu animated:YES];
    
    
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
//    cell.backgroundColor = [UIColor blueColor];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 0: //账号
        {
            if([AnquUser sharedSingleton].username!=nil){
                SafeHome *safe = [[SafeHome alloc] init];
                [self presentModalViewController:safe animated:YES];
            }else{
                [UserData showMessage:@"客官，请您先登录。"];
                return;

            }
           
        }
            break;
            
        case 1:  //客服中心
        {
            //增加一个Toast提示，暂未实现......
            [UserData showMessage:@"客官，请联系客服邮箱:kefu@anqu.com."];
//            AcountWeb *acountWeb = [[AcountWeb alloc] init];
//            acountWeb.payway = 1;
//            [self presentModalViewController:acountWeb animated:YES];
        }
            break;
            
        case 2: // 原为论坛，现为忘记密码
        {
            ForgetPass *forpass = [[ForgetPass alloc] init];
            [self presentModalViewController:forpass animated:YES];
        }
            break;
            
//        case 3:      //活动
//        {
//             [self showMessage:@"客官，正在努力建设中..."];
//            AcountWeb *acountWeb = [[AcountWeb alloc] init];
//            acountWeb.payway = 3;
//           [self presentModalViewController:acountWeb animated:YES];
//        }
//            break;
            
        case 3:         //注销
        {
            if([AnquUser sharedSingleton].username!=nil){
                LoginOut *anquOut = [[LoginOut alloc] init];
                [self presentModalViewController:anquOut animated:YES];
            }else{
                [UserData showMessage:@"客官，请您先登录。"];
                return;
                
            }

        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
    return 50; //定值
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

-(BOOL)shouldAutorotate
{
    return NO;
}


//iOS旋屏支持方向
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


//iOS 6.0以下旋屏
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
//        return YES;
//    }
//    return NO;
//}

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
