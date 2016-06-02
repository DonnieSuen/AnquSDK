//
//  Paymethod.m
//  AnquIOSSDK
//
//  Created by jiangfeng on 15/4/8.
//  Copyright (c) 2015年 anqu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Paymethod.h"

@implementation Paymethod

int ddLogLevel;

+ (Paymethod *)sharedSingleton{
    static Paymethod *sharedSingleton = nil;
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[Paymethod alloc] init];
            ddLogLevel =[AnquInterfaceKit getLoggerLevel];
            return sharedSingleton;
        }
    }
    return sharedSingleton;
}

+(void)paywithSZF
{
    
    // 实际支付请求处理，包裹成方法供kit.m调用
    NSString *source = @"";
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    //NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
    NSString *cardmoney = [OrderInfo sharedSingleton].cardNorMoney; //面值
    NSString *cardNum = [OrderInfo sharedSingleton].cardNo;
    NSString *cardpwd = [OrderInfo sharedSingleton].cardpass;
    NSString *verifyType = @"1"; //MD5校验
    NSString *version = @"3";
    NSString *merId = @"172802";//商户号
    NSString *returnUrl = @"http://42.62.30.107:10055/index.php/shenzhoufu/Notifyurl/";
    NSString *privateKey = @"BehVLQHz";
    NSString *MerchantName = @"安趣科技有限公司";
    NSString *cardType = [self getCardtype:cardNum Cardpw:cardpwd];
    
    //@"30@14371120104461316@121573894029953158";
    source = [source stringByAppendingFormat:@"%@@%@@%@",cardmoney,cardNum,cardpwd];
    NSData *source_data = [source dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [self DESEncrypt:source_data WithKey:@"3wQfnXPIEAI=)"];
    NSString *encrptedInfo = [data base64EncodedStringWithOptions:0];
    DDLogDebug(@"神州付base64_result:%@,面值%@", encrptedInfo,cardmoney);
    
    NSString *privateField = [self getPrivateField];
    NSString *payMoney =  [NSString stringWithFormat:@"%d",[[OrderInfo sharedSingleton].money intValue]*100];
    
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@%@", version,merId,payMoney,[OrderInfo sharedSingleton].anquOrderid,returnUrl, encrptedInfo, privateField, verifyType,privateKey];
    
    DDLogDebug(@"Md5 sign = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:version, @"version",merId, @"merId",payMoney,@"payMoney",
                                [OrderInfo sharedSingleton].anquOrderid, @"orderId",
                                returnUrl, @"returnUrl",
                                encrptedInfo, @"cardInfo",
                                MerchantName, @"merUserName",
                                privateField, @"privateField",
                                verifyType, @"verifyType",
                                cardType, @"cardTypeCombine",
                                [MyMD5 md5:sign], @"md5String",nil];
    
    NSString *postData = [dictionary buildQueryString];
    
    DDLogDebug(@"神州付postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(cardpay_callback:);
    _request.error = @selector(cardpay_error);
    [_request post:API_URL_SZF argData:postData]; //API_URL_COIN
    
    //    NSLog(@"last post =%@", [_payUrl stringByAppendingFormat:@"%@%@", @"?", postData]);
    //    _payDelegateUrl = [_payUrl stringByAppendingFormat:@"%@%@", @"?", postData];
    //
    //    PayWebView *paywebHtml = [[PayWebView alloc] init];
    //    paywebHtml.payway = _payway;
    //    paywebHtml.webUrl = _payDelegateUrl;
    //    [self presentModalViewController:paywebHtml animated:YES];
}

+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCKeySizeAES256;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    NSData *keyData = [[NSData alloc] initWithBase64EncodedString:key options:0];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode ,
                                          [keyData bytes], kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

+(NSString *)getCardtype:(NSString *)cardno Cardpw:(NSString*)password
{
    NSString *cardType=@"";
    NSUInteger cardlen = cardno.length;
    NSUInteger pwdlen = password.length;
    if((cardlen == 16 && pwdlen == 17)||(cardlen == 16 && pwdlen ==21) ||(cardlen == 17 && pwdlen ==18) || (cardlen == 10 && pwdlen == 8))
        cardType = @"000"; //移动卡
    else if(cardlen == 15 && pwdlen == 19) cardType = @"001";
    else if(cardlen == 19 && pwdlen == 18) cardType = @"002";
    
    return cardType;
    
}

+(NSString *) getPrivateField
{
    //实例化NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"MMddHHmmss"];
    
    //[NSDate date]获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    DDLogDebug(@"神州付私有串为%@",currentDateStr);
    
    return currentDateStr;
    //alloc后对不使用的对象别忘了release
    //[dateFormatter release];
}


@end
