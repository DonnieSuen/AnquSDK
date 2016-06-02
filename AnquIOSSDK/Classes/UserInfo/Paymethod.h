//
//  Paymethod.h
//  AnquIOSSDK
//
//  Created by jiangfeng on 15/4/8.
//  Copyright (c) 2015年 anqu. All rights reserved.
//

#ifndef AnquIOSSDK_Paymethod_h
#define AnquIOSSDK_Paymethod_h


#endif

#import "AppInfo.h"
#import "OrderInfo.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "httpRequest.h"
#import "HttpUrl.h"
#import "SBJsonParser.h"
#import <CommonCrypto/CommonCryptor.h>


@interface Paymethod : NSObject{
}

+ (Paymethod *)sharedSingleton;


+(void)paywithSZF;

//+(void)update:(NSString*)username;
@end