//
//  AppInfo.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.

//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

+ (AppInfo *)sharedSingleton;

@property(strong, nonatomic)NSString *partnerID; //cpuid
@property(strong, nonatomic)NSString *gameID;  //appid
@property(strong, nonatomic)NSString *gameKey;//mAppkey--appkey
@property(strong, nonatomic)NSString *channelID;//渠道ID
@property(strong,nonatomic) NSString *partnerKey;//privateKey

@property(strong, nonatomic)NSMutableArray *bankMutableArray;
@property(strong, nonatomic)NSMutableArray *bankNameArray;


-(void)initWithType:(NSString*)appID GameKey:(NSString*)appKey SourceID:(NSString*)channelID;

-(NSString*)getData;

@end
