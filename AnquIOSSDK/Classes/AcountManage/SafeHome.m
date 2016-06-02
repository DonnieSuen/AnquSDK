//
//  SafeHome.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "SafeHome.h"
#import "AnquUser.h"
#import "Kefuconnect.h"

@interface SafeHome ()

@end

@implementation SafeHome

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popFinish:) name:@"LoginOut_close" object:nil];
    
    _anquArray = [NSArray arrayWithObjects:@"个人资料", @"修改密码", @"绑定手机", nil];
    _anquImageArray = [NSArray arrayWithObjects:@"anqu_person_account", @"anqu_person_modify_pwd", @"anqu_person_binding_phone", nil];
    [self initSafeHome];
    // Do any additional setup after loading the view.
}

-(void)initSafeHome
{
    //_orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    _orientation = [AnquInterfaceKit getOrientation];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(anquAcountBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _anquPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _anquPayText.text = @"账号安全";
    _anquPayText.font = [UIFont systemFontOfSize:20.0];
    _anquPayText.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_anquPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"anqu_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(anquCustomClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _anquSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _anquSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"anqu_split_line"];
    [self.view addSubview:_anquSplitLine];
    
    _anquTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 65, 40, 20)];
    _anquTitle.text = @"尊敬的:";
    _anquTitle.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_anquTitle];
    
    _anquUserName = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 65, 60, 20)];
    //_anquUserName.text = @"anqu_hero";
    _anquUserName.text = [AnquUser sharedSingleton].username;
    _anquUserName.font = [UIFont systemFontOfSize:12.0];
    _anquUserName.textColor = [UIColor orangeColor];
    [self.view addSubview:_anquUserName];
    
    _anquWel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 + 20, 65, 100, 20)];
    _anquWel.font = [UIFont systemFontOfSize:12.0];
    _anquWel.text = @"欢迎来到个人中心";
    [self.view addSubview:_anquWel];
    
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
            HumanResources *huMan = [[HumanResources alloc] init];
           [self presentModalViewController:huMan animated:YES];
        }
            break;
        case 1:
        {
            ModifyPwd *modifypwd = [[ModifyPwd alloc] init];
            [self presentModalViewController:modifypwd animated:YES];
            
        }
            break;
            
        case 2:
        {
            BindPhone *bind = [[BindPhone alloc] init];
            [self presentModalViewController:bind animated:YES];
        }
            break;
        
      
            
//        default:
//        {
//            HumanResources *huMan = [[HumanResources alloc] init];
//            [self presentModalViewController:huMan animated:YES];
//
//        }
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

-(void)anquCustomClick
{
//    AcountWeb *web = [[AcountWeb alloc] init];
//    web.payway = 1;
//    [self presentModalViewController:web animated:YES];
    Kefuconnect *kefu = [[Kefuconnect alloc] init];
    [self presentModalViewController:kefu animated:YES];
    
}

-(void)anquAcountBackClick:(id)sender
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
