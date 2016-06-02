//
//  IPAddress.h
//  AnquIOSSDK
//
//  Created by jiangfeng on 15/4/11.
//  Copyright (c) 2015年 anqu. All rights reserved.
//

#ifndef AnquIOSSDK_IPAddress_h
#define AnquIOSSDK_IPAddress_h


#endif

#define MAXADDRS    32
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface IPAddress : NSObject

+(NSString *)getIPAddress:(BOOL)preferIPv4;
+(NSDictionary *)getIPAddresses;

@end