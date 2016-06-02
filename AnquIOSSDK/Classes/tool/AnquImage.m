//
//  AnquImage.m
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "AnquImage.h"

@implementation AnquImage

//自动处理拉升或者缩放图片纹理
-(UIImage *)HandlingPicturesWithPic:(UIImage *)AImage TopWidth:(CGFloat)ATopWidth LeftWidth:(CGFloat)ALeftWidth BelowWidth:(CGFloat)ABelowWidth RightWidth:(CGFloat)ARightWidth
{
    UIImage *ANewImage;
    if (CurrentSystemVersion >= 5.0)
    {
        ANewImage = [AImage resizableImageWithCapInsets:UIEdgeInsetsMake(ATopWidth, ALeftWidth, ABelowWidth, ARightWidth)];
    }
    else
    {
        ANewImage=[AImage stretchableImageWithLeftCapWidth:ATopWidth topCapHeight:ALeftWidth];
    }
    return ANewImage;
}

@end
