//
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CurrentSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

@interface AnquImage : NSObject

-(UIImage *)HandlingPicturesWithPic:(UIImage *)AImage TopWidth:(CGFloat)ATopWidth LeftWidth:(CGFloat)ALeftWidth BelowWidth:(CGFloat)ABelowWidth RightWidth:(CGFloat)ARightWidth;

@end
