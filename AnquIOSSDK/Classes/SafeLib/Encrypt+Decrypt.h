//
//  Encrypt+Decrypt.h
//  YayawanIOS
//
//  Created by andsky on 14-4-15.
//

#import <Foundation/Foundation.h>
typedef enum {
    kEncryptionModeDisk = 0,
    kEncryptionModeMemory
} CPEncryptionMode;


@interface Encrypt_Decrypt : NSObject
+ (Encrypt_Decrypt *)sharedController;
@property (strong, nonatomic) NSData *encryptedData;
@property (strong, nonatomic) NSData *iv;
@property (strong, nonatomic) NSData *salt;
@property (assign, nonatomic) CPEncryptionMode encryptionMode;

- (BOOL)encryptData:(NSData *)data password:(NSString *)password error:(NSError **)error;
- (NSData *)decryptDataWithPassword:(NSString *)password error:(NSError **)error;
@end
