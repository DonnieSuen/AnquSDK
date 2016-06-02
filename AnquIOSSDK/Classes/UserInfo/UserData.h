//
//  User.h
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSON.h"
#import "NSData+ASE128.h"
#import "OrderInfo.h"
#import "HttpUrl.h"
#import "NSData+hexRepresentationWithSpaces_AS.h"
#import "NSString+dataFromHexString.h"

@interface UserData : NSObject{
//    NSString *username;
//    NSString *uid;
//    NSString *token;
}

+ (UserData *)sharedSingleton;

@property(strong, nonatomic)NSString *username;
@property(strong, nonatomic)NSString *uid;
@property(strong, nonatomic)NSString *token;
@property(nonatomic, retain)NSString *amount;

+(void)push:(NSString*)username password:(NSString*)argPassword;
+(NSDictionary *)get;
+(void)pop:(NSString*)username;
+(NSDictionary *)get;
+(void)update:(NSString*)username;

+(void)showMessage:(NSString*)msg;
+(void)updateOrderInfo;
+(bool)isLandscape:(UIInterfaceOrientation) orientation;
@end
