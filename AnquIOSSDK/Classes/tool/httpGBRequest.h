//
//  httpGBRequest.h
//  AnquIOSSDK
//
//  Created by jiangfeng on 15/4/13.
//  Copyright (c) 2015年 anqu. All rights reserved.
//

#ifndef AnquIOSSDK_httpGBRequest_h
#define AnquIOSSDK_httpGBRequest_h

#endif

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface httpGBRequest : NSObject<NSURLConnectionDataDelegate,MBProgressHUDDelegate>{
    
}

@property(nonatomic,retain)id dlegate;

@property(nonatomic, retain)NSMutableData *receivedData;

@property(nonatomic, assign)SEL success;

@property(nonatomic, assign)SEL error;

@property(nonatomic, assign)BOOL HUD_FLAG;

@property(nonatomic, retain)MBProgressHUD *HUD;


/**
 *  post 异步请求
 *
 *  @param url  post 异步请求地址
 *  @param data post 请求参数
 */
-(void)postGBK:(NSString*)url argData:(NSString*)data;


@end
