//
//  AppInfo.m
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

+ (AppInfo *)sharedSingleton{
    static AppInfo *sharedSingleton = nil;
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[AppInfo alloc] init];
            return sharedSingleton;
        }
    }
    return sharedSingleton;
}

//自定义user类传值
-(void)initWithType:(NSString*)appID GameKey:(NSString*)appKey SourceID:(NSString*)channelID{
    _gameID = appID;
    _gameKey = appKey;
    _channelID = channelID;
}

-(NSString*)getData
{
    int unixtime = [[NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]] integerValue];
    NSString *date = [NSString stringWithFormat:@"%d", unixtime];
    return date;
}
@end
