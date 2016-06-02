//
//  ActivateInfo.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "ActivateInfo.h"

@implementation ActivateInfo

+ (ActivateInfo *)sharedSingleton{
    static ActivateInfo *sharedSingleton = nil;
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[ActivateInfo alloc] init];
            return sharedSingleton;
        }
    }
    return sharedSingleton;
}

//自定义ActivateInfo
-(void)initWithType:(NSString*)tempDeviceno GameKey:(NSString*)tempPassport Relation:(NSString*)relation
{
    _deviceno = tempDeviceno;
    _passport = tempPassport;
    _relationships = relation;
}

@end
