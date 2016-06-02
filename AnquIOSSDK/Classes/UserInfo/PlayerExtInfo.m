//
//  PlayerExtInfo.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//


#import "PlayerExtInfo.h"

//#define SCREENHEIGHT [GetImage screenSize].height
//#define SCREENWIDTH [GetImage screenSize].width

@interface PlayerExtInfo ()


@end

@implementation PlayerExtInfo

int ddLogLevel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         ddLogLevel =[AnquInterfaceKit getLoggerLevel];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)submitExtInfo{
    if ([AnquUser sharedSingleton].uid ==nil) {
        DDLogDebug(@"请先登陆");
        [_delegate AnquPlayerSubmit:AnquNoExtSubmit];
        return;
    }
    
    NSString *sign = @"";
    //时间戳
    UInt64 serial = [[NSDate date] timeIntervalSince1970]*1000;
    NSNumber *longlongNumber = [NSNumber numberWithLongLong:serial];
    NSString *stamp = [longlongNumber stringValue];
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@%@", [AnquUser sharedSingleton].uid, [AppInfo sharedSingleton].partnerID,[AppInfo sharedSingleton].gameID, [OrderInfo sharedSingleton].roleId,[OrderInfo sharedSingleton].roleName,[OrderInfo sharedSingleton].roleLevel,[OrderInfo sharedSingleton].serverId,[OrderInfo sharedSingleton].serverName,signKey];
    
    DDLogDebug(@"提交扩展数据sign = %@", sign);
    //   CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    NSString *mark =  @"loginGameRole";
    NSString *fromos = @"1";
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [AnquUser sharedSingleton].uid, @"uid",
                                [AppInfo  sharedSingleton].partnerID,@"cpid",
                                [AppInfo sharedSingleton].gameID, @"appid",
                                mark, @"mark",
                                fromos, @"fromos",
                                [OrderInfo sharedSingleton].roleId, @"roleid",
                                [OrderInfo sharedSingleton].roleName, @"rolename",
                                [OrderInfo sharedSingleton].roleLevel, @"rolelevel",
                                [OrderInfo sharedSingleton].serverId, @"zoneid",
                                [OrderInfo sharedSingleton].serverName,@"zonename",
                                stamp,@"timestamp",
                                [MyMD5 md5:sign], @"sign",nil];
    
    //    NSEnumerator * enumerator = [dictionary keyEnumerator];
    //    //定义一个不确定类型的对象
    //    id object;
    //    //遍历输出
    //    while(object = [enumerator nextObject])
    //    {
    //        NSLog(@"键值为：%@",object);
    //        //通过NSDictionary对象的objectForKey方法来得到
    //        id objectValue = [dictionary objectForKey:object];
    //        if(objectValue != nil)
    //        {
    //            NSLog(@"%@所对应的value是 %@",object,objectValue);
    //        }
    //
    //    }
    
    NSString *postData = [dictionary buildQueryString];
    
    DDLogDebug(@"提交扩展的数据:%@,url is %@",postData,API_URL_PLAYERINFO);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(playInfo_callback:);
    _request.error = @selector(playInfo_error_callback);
    [_request post:API_URL_PLAYERINFO argData:postData];
    
}

-(void)playInfo_error_callback
{
    [UserData showMessage:@"网络连接超时"];

     [_delegate AnquPlayerSubmit:AnquNoExtSubmit];
    //[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playInfo_callback:(NSString*)result
{
    DDLogDebug(@"提交扩展result = %@", result);
//    NSError *error = nil;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];

    NSString *status = [rootDic objectForKey:@"status"];
    if([status intValue] == 0||[status intValue] == 1){
        
        //成功，callback  提交扩展后才能支付
        [_delegate AnquPlayerSubmit:AnquExtSubSuccess];
        
        [self dismissModalViewControllerAnimated:NO];
        
    }else{
        DDLogError(@"出现错误，%@",[rootDic objectForKey:@"msg"]);
        
         [_delegate AnquPlayerSubmit:AnquExtSubFail];
        [UserData showMessage:[rootDic objectForKey:@"msg"]];
    }

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


@end
