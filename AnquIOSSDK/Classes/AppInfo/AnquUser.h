//
//  User.h
//  AnquUser
//
//

#import <Foundation/Foundation.h>

@interface AnquUser : NSObject

+ (AnquUser *)sharedSingleton;

@property(nonatomic,strong)NSString *uid;
@property(nonatomic, strong)NSString *username;
@property(nonatomic, strong)NSString *passwd;
@property(nonatomic, strong)NSString *sessiond;

-(void)initWithType:(NSString*)anquName Pwd:(NSString*)anquPwd Sessiond:(NSString*)anquSessiond Uid:(NSString*)anquUid;

@end
