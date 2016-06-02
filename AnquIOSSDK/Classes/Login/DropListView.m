

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "DropListView.h"
#import "GetImage.h"
#import "DropCell.h"

@implementation DropListView

@synthesize tv,tableArray,textBtn,textField,positionDelegate;

- (void)dealloc
{
    [tv release];
    [tableArray release];
  
    [super dealloc];
    
}


-(id)initWithFrame:(CGRect)frame

{
    if (frame.size.height<200) {
        frameHeight = 200;
        }else{
        frameHeight = frame.size.height;
        }
    tabheight = frameHeight-30;
    frame.size.height = 30.0f;
    self=[super initWithFrame:frame];
    if(self){
        showList = NO; //默认不显示下拉框
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width - 2, 0)];
        tv.delegate = self;
        tv.dataSource = self;
        [tv setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        tv.backgroundColor = [UIColor whiteColor];
        tv.separatorColor = [UIColor darkGrayColor];
        tv.hidden = YES;
        [self addSubview:tv];
        
        //文本框
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
//        textField.font = [UIFont systemFontOfSize:8.0f];
        textField.placeholder = @" 用户名";
        textField.textAlignment = NSTextAlignmentLeft; //水平左对齐
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
        //最左侧加图片是以下代码
        
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 50)];
        UIImageView *userLogoImage=[[UIImageView alloc] initWithImage:[GetImage getSmallRectImage:@"anqu_login_user"]];
        userLogoImage.frame = CGRectMake(7, 12, 25, 25);
        [leftview addSubview:userLogoImage];
        textField.leftView = leftview;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:textField];
        
        textBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        textBtn.frame= CGRectMake(frame.size.width - 40, 10, 33, 30);
        [textBtn setBackgroundImage:[GetImage imagesNamedFromCustomBundle:@"anqu_spinner"] forState:UIControlStateNormal];
        [textBtn addTarget:self action:@selector(dropdown) forControlEvents: UIControlEventTouchUpInside];//处理点击
        [self addSubview:textBtn];
    }
    return self;
}

-(void)dropdown{
    [textBtn resignFirstResponder];
    if([tableArray count] == 0){
        tv.hidden = YES;
        
        showList = NO;
        CGRect sf = self.frame;
        sf.size.height = 30;
        self.frame = sf;
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
        
        return;
    }
    
    if (showList) {//如果下拉框已显示，什么都不做
        tv.hidden = YES;
        showList = NO;
        CGRect sf = self.frame;
        sf.size.height = 30;
        self.frame = sf;
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
    }else{//如果下拉框尚未显示，则进行显示
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        tv.hidden = NO;
        showList = YES;//显示下拉框
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        tv.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DropCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[DropCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if ([indexPath row]%2 == 0) {
        cell.backgroundColor = UIColorFromRGB(0xf6f6f6);
    }
    else
    {
        cell.backgroundColor = UIColorFromRGB(0xffffff);
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    cell.deleteButton.frame= CGRectMake(self.frame.size.width - 40, 5, 33, 40);
    cell.deleteButton.contentMode = UIViewContentModeScaleToFill;
    [cell.deleteButton setBackgroundImage:[GetImage imagesNamedFromCustomBundle:@"anqu_close"] forState:UIControlStateNormal];
    cell.deleteButton.tag = [indexPath row];
    [cell.deleteButton addTarget:self action:@selector(celldeleteClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    
}

-(void)celldeleteClick:(id)sender{
    NSLog(@"my god");
    UIButton *AButton=sender;
    NSInteger _lastIndex = AButton.tag;
    [positionDelegate setCleanIndex:_lastIndex];
    [tv reloadData];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    textField.text = [tableArray objectAtIndex:[indexPath row]];
    [positionDelegate setPasswdText:[indexPath row]];
    showList = NO;
    tv.hidden = YES;
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}


@end
