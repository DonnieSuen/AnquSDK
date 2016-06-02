//
//  checkWifi.h
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnquReachability.h"

@interface checkWifi : NSObject

+(BOOL)connectedToNetWork;
+(BOOL)IsEnableWIFI;
//
+(BOOL)IsEnable3G;
@end
