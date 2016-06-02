//
//  ActivateInfo.h

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivateInfo : NSObject

+ (ActivateInfo *)sharedSingleton;

@property(nonatomic, strong)NSString *deviceno;

@property(nonatomic, strong)NSString *passport;

@property(nonatomic, strong)NSString *relationships;  //是否绑定手机 快速注册

@end
