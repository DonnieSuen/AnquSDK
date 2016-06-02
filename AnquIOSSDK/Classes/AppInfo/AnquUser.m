//
//  User.m
//
//  Created by Jeff on 15-3-21.

//

#import "AnquUser.h"

@implementation AnquUser

+ (AnquUser *)sharedSingleton
{
    static AnquUser *sharedSingleton = nil;
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[AnquUser alloc] init];
            return sharedSingleton;
        }
    }
    return sharedSingleton;
}

-(void)initWithType:(NSString*)anquName Pwd:(NSString*)anquPwd Sessiond:(NSString*)anquSessiond Uid:(NSString*)anquUid
{
    _username = anquName;
    _passwd = anquPwd;
    _uid = anquUid;
    _sessiond = anquSessiond;
}

@end
