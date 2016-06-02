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
#import "httpRequest.h"
#import "MyMD5.h"
#import "ActivateInfo.h"
#import "SBJsonParser.h"
#import "GetImage.h"
#import "NSDictionary+QueryBuilder.h"
#import "OrderInfo.h"
#import "RCDraggableButton.h"
#import "AnquInterfaceKit.h"
#import "QCheckBox.h"
#import "UserData.h"

@interface PlayerExtInfo : UIViewController

@property(nonatomic, retain)id<AnquCallback> delegate;

-(void)submitExtInfo;

@end
