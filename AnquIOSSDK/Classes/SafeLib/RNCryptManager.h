//
//  RNCryptManager.h
//  KeyChainDemo
//
//  Created by andsky on 14-4-15.
//
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

extern NSString * const kRNCryptManagerErrorDomain;

@interface RNCryptManager : NSObject
+ (BOOL)encryptFromStream:(NSInputStream *)fromStream
                 toStream:(NSOutputStream *)toStream
                 password:(NSString *)password
                    error:(NSError **)error;

+ (BOOL)decryptFromStream:(NSInputStream *)fromStream
                 toStream:(NSOutputStream *)toStream
                 password:(NSString *)password
                    error:(NSError **)error;

+ (NSData *)encryptedDataForData:(NSData *)data
                        password:(NSString *)password
                              iv:(NSData **)iv
                            salt:(NSData **)salt
                           error:(NSError **)error;

+ (NSData *)decryptedDataForData:(NSData *)data
                        password:(NSString *)password
                              iv:(NSData *)iv
                            salt:(NSData *)salt
                           error:(NSError **)error;
@end
