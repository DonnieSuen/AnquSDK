//
//  checkWifi.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "checkWifi.h"
#import<SystemConfiguration/SystemConfiguration.h>
#import<netdb.h>

@implementation checkWifi

+(BOOL)connectedToNetWork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

// 是否wifi
+(BOOL)IsEnableWIFI{
    return ([[AnquReachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+(BOOL)IsEnable3G{
    return ([[AnquReachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

@end
