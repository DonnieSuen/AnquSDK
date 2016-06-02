//
//  Activate.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnquCallback.h"
#import "MBProgressHUD.h"
#import "AppInfo.h"
#import "HttpUrl.h"
#import "qqMac.h"
#import "httpRequest.h"
#import "MyMD5.h"
#import "ActivateInfo.h"
#import "SBJsonParser.h"
#import "AnquKitConfig.h"
#import "NSDictionary+QueryBuilder.h"
#import "GetImage.h"
#import "SvUDIDTools.h"
#import "UserData.h"
#import "DDLog.h"
#import "AnquInterfaceKit.h"

@interface Activate : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *anquLogo;

@property (strong, nonatomic) IBOutlet UIButton *anquBt;

@property(nonatomic, retain)id<AnquCallback> delegate;

@property(nonatomic, retain)MBProgressHUD *HUD;

-(void)activiateToAnqu:(UIViewController*)viewController;

@end
