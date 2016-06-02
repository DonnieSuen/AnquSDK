//
//  User.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.


#import "UserData.h"

@implementation UserData

+ (UserData *)sharedSingleton{
    static UserData *sharedSingleton = nil;
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[UserData alloc] init];
            return sharedSingleton;
        }
    }
    return sharedSingleton;
}

+(void)push:(NSString*)username password:(NSString*)argPassword{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *_userAesDataHex = [defaults objectForKey:@"AnquUserDataA"];
    NSData *_userAesData = [[_userAesDataHex dataFromHexString] AES128DecryptWithKey:@"Anqupasswordkey"];
    NSString *_userData = [[NSString alloc] initWithData:_userAesData encoding:NSUTF8StringEncoding];
    NSDictionary *_JsonParserResult = [_userData JSONValue];
    
    if ([_JsonParserResult objectForKey:username]) {
//        return;
    }
    NSMutableDictionary *mutableRetrievedDictionary;
    if (_JsonParserResult == NULL) {
        mutableRetrievedDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    }else{
        mutableRetrievedDictionary = [_JsonParserResult mutableCopy];
    }
    
    int unixtime = [[NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]] integerValue];
    
    NSDictionary *_userName = [NSDictionary dictionaryWithObjectsAndKeys: username,@"username",
                                argPassword,@"password", 
                               [NSString stringWithFormat:@"%d", unixtime] ,@"last_date",nil];
    [mutableRetrievedDictionary setObject:_userName forKey:username];
    //[data dataUsingEncoding:NSUTF8StringEncoding]
    NSData *_aesData = [[[mutableRetrievedDictionary JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:@"Anqupasswordkey"];
    NSString *_aexStringHex = [_aesData hexRepresentationWithSpaces_AS:NO];
    //NSLog(@"用户数据UserData aes-----%@", _aexStringHex);

    [defaults setObject:_aexStringHex forKey:@"AnquUserDataA"];
    [defaults synchronize];

}

+(void)pop:(NSString*)username{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *_userAesDataHex = [defaults objectForKey:@"AnquUserDataA"];
    NSData *_userAesData = [[_userAesDataHex dataFromHexString] AES128DecryptWithKey:@"Anqupasswordkey"];
    NSString *_userData = [[NSString alloc] initWithData:_userAesData encoding:NSUTF8StringEncoding];
    NSDictionary *_JsonParserResult = [_userData JSONValue];
    
    if (![_JsonParserResult objectForKey:username]) {
        return;
    }
    
    NSMutableDictionary *mutableRetrievedDictionary;
    mutableRetrievedDictionary = [_JsonParserResult mutableCopy];
    
    [mutableRetrievedDictionary removeObjectForKey:username];
    
    NSData *_aesData = [[[mutableRetrievedDictionary JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:@"Anqupasswordkey"];
    NSString *_aexStringHex = [_aesData hexRepresentationWithSpaces_AS:NO];
    
    [defaults setObject:_aexStringHex forKey:@"AnquUserDataA"];
    [defaults synchronize];
    
}

+(NSDictionary *)get{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *_userAesDataHexString = [defaults objectForKey:@"AnquUserDataA"];
    NSData *_userAesHexData = [_userAesDataHexString dataFromHexString];
    NSData *_userAesData = [_userAesHexData AES128DecryptWithKey:@"Anqupasswordkey"];
    NSString *_userData = [[NSString alloc] initWithData:_userAesData encoding:NSUTF8StringEncoding];
//    NSMutableString   *_userData = [[NSString alloc] initWithData:_userAesData encoding:NSUTF8StringEncoding]; //be to...
    NSDictionary *_JsonParserResult = [_userData JSONValue];
    return  _JsonParserResult;
}

+(void)update:(NSString*)username{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *_userData = [defaults objectForKey:@"AnquUserDataA"];
    NSDictionary *_JsonParserResult = [_userData JSONValue];
    NSDictionary *_userInfo = [_JsonParserResult objectForKey:username];
    if (_userInfo == nil) {
        return;
    }
    
    int unixtime = [[NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]] integerValue];
    
    NSMutableDictionary *mutableRetrievedDictionary;
    mutableRetrievedDictionary = [_JsonParserResult mutableCopy];
    
    NSDictionary *_userName = [NSDictionary dictionaryWithObjectsAndKeys: username,@"username",
                               [_userInfo objectForKey:@"password"],@"password",
                               [NSString stringWithFormat:@"%d", unixtime] ,@"last_date",nil];
    [mutableRetrievedDictionary setObject:_userName forKey:username];
    [defaults setObject:[mutableRetrievedDictionary JSONRepresentation] forKey:@"AnquUserDataA"];
    [defaults synchronize];
}

+(void)showMessage:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

+(void)updateOrderInfo{
    [OrderInfo sharedSingleton].transNum=@"";
    [OrderInfo sharedSingleton].cardNo=@"";
    [OrderInfo sharedSingleton].cardNorMoney=@"";
    [OrderInfo sharedSingleton].cardpass=@"";
    [OrderInfo sharedSingleton].alipayDesc=@"";
    [OrderInfo sharedSingleton].orderAnquInnerDescription=@"";
 //   NSString * paytype = [OrderInfo sharedSingleton].type;
    
//    if ([OrderInfo sharedSingleton].type == nil) {
//       [OrderInfo sharedSingleton].payname = @"";
//    }else if([paytype isEqualToString: ALIPAYID]){
//        [OrderInfo sharedSingleton].payname = @"支付宝";
//
//    }else if([paytype isEqualToString: UPPAYID]){
//        [OrderInfo sharedSingleton].payname = @"银联";
//        
//    }else if([paytype isEqualToString: SZFPAYID]){
//        [OrderInfo sharedSingleton].payname = @"神州付";
//        
//    }else if([paytype isEqualToString: WEIXINPAYID]){
//        [OrderInfo sharedSingleton].payname = @"微信支付";
//        
//    }else if([paytype isEqualToString: JUNWANGPAYID]){
//        [OrderInfo sharedSingleton].payname = @"骏网卡";
//        
//    }

}

+(bool)isLandscape:(UIInterfaceOrientation) orientation
{
    return
    !UIDeviceOrientationIsPortrait(orientation) ||
    !UIInterfaceOrientationIsPortrait(orientation );
}

@end
