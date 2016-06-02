//
//  Encrypt+Decrypt.m
//  YayawanIOS
//
//  Created by andsky on 14-4-15.
//

#import "Encrypt+Decrypt.h"
#import "RNCryptManager.h"

static NSString * const kModeKey = @"mode";


@implementation Encrypt_Decrypt

@synthesize encryptedData=encryptedData_;
@synthesize iv=iv_;
@synthesize salt=salt_;
@synthesize encryptionMode=encryptionMode_;

+ (Encrypt_Decrypt *)sharedController {
    static Encrypt_Decrypt *sSharedController;
    if (! sSharedController) {
        sSharedController = [[Encrypt_Decrypt alloc] init];
    }
    return sSharedController;
}

- (BOOL)encryptDataInMemory:(NSData *)data password:(NSString *)password error:(NSError **)error {
    NSData *iv;
    NSData *salt;
    self.encryptedData = [RNCryptManager encryptedDataForData:data password:password iv:&iv salt:&salt error:error];
    self.iv = iv;
    self.salt = salt;
    return self.encryptedData ? YES : NO;
}


- (BOOL)encryptDataWithStream:(NSData *)data password:(NSString *)password error:(NSError **)error {
    
    NSInputStream *pictureStream = [NSInputStream
                                    inputStreamWithData:data];
    [pictureStream open];
    
    NSString *encryptedPath =
    [NSTemporaryDirectory()
     stringByAppendingPathComponent:@"encrypted.dat"];
    
    NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:encryptedPath
                                                                     append:NO];
    [outputStream open];
    
    BOOL result = [RNCryptManager encryptFromStream:pictureStream
                                           toStream:outputStream
                                           password:password
                                              error:error];
    [pictureStream close];
    [outputStream close];
    return result;
}


- (BOOL)encryptData:(NSData *)data password:(NSString *)password error:(NSError **)error {
    if ([self encryptionMode] == kEncryptionModeDisk) {
        return [self encryptDataWithStream:data password:password error:error];
    }
    else {
        return [self encryptDataInMemory:data password:password error:error];
    }
}

- (NSData *)decryptStreamDataWithPassword:(NSString *)password error:(NSError **)error {
    NSString *encryptedPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"encrypted.dat"];
    NSInputStream *inStream = [NSInputStream inputStreamWithFileAtPath:encryptedPath];
    [inStream open];
    
    NSOutputStream *outStream = [NSOutputStream outputStreamToMemory];
    [outStream open];
    
    NSData *data = nil;
    if ([RNCryptManager decryptFromStream:inStream toStream:outStream password:password error:error]) {
        data = [outStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    }
    
    [inStream close];
    [outStream close];
    return data;
}

- (NSData *)decryptMemoryDataWithPassword:(NSString *)password error:(NSError **)error {
    return [RNCryptManager decryptedDataForData:self.encryptedData password:password iv:self.iv salt:self.salt error:error];
}

- (NSData *)decryptDataWithPassword:(NSString *)password error:(NSError **)error {
    if ([self encryptionMode] == kEncryptionModeDisk) {
        return [self decryptStreamDataWithPassword:password error:error];
    }
    else {
        return [self decryptMemoryDataWithPassword:password error:error];
    }
    
}




@end
