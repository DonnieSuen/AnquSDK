//
//  Floating.m
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import "Floating.h"
#import "GetImage.h"

@implementation Floating

+(void)initFloating:(UIView*)tabBarView Context:(UIViewController*)tempContext{
    //tab bar view  始终居中显示
    tabBarView = [[UIView alloc] initWithFrame:CGRectMake(tempContext.view.frame.size.width/2-100, tempContext.view.frame.size.height/2-100, 200 , 200)] ;
    
    //view 设置半透明 圆角样式
    //tabBarView.layer.cornerRadius = 10;//设置圆角的大小
    //tabBarView.layer.backgroundColor = [[UIColor blackColor] CGColor];
    tabBarView.alpha = 0.8f;//设置透明
    //tabBarView.layer.masksToBounds = YES;
    
//    [tempContext.view addSubview:tabBarView];
    [[UIApplication sharedApplication].keyWindow addSubview:tabBarView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:tabBarView];
    
    //循环设置tabbar上的button
    NSArray *imgNames = [[NSArray alloc]initWithObjects:@"download",@"block",@"bluetooth",@"file", nil];
    NSArray *tabTitle = [[NSArray alloc]initWithObjects:@"download",@"block",@"bluetooth",@"file", nil];
    
    for (int i=0; i<4; i++) {
        CGRect rect;
        rect.size.width = 60;
        rect.size.height = 60;
        switch (i) {
            case 0:
                rect.origin.x = 100-30;
                rect.origin.y = 40-30;
                break;
            case 1:
                rect.origin.x = 160-30;
                rect.origin.y = 100-30;
                break;
            case 2:
                rect.origin.x = 100-30;
                rect.origin.y = 160-30;
                break;
            case 3:
                rect.origin.x = 40-30;
                rect.origin.y = 100-30;
                break;
        }
        
        //设置每个tabView
        UIView *tabView = [[UIView alloc] initWithFrame:rect];
        [tabBarView addSubview:tabView];
        
        //设置tabView的图标
        UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.frame = CGRectMake(15, 0, 30, 30);
//        [tabButton setBackgroundImage:[UIImage imageNamed:[imgNames objectAtIndex:i]] forState:UIControlStateNormal];
        [tabButton setBackgroundImage:[GetImage getRectImage:[imgNames objectAtIndex:i]] forState:UIControlStateNormal];
        [tabButton setTag:i];
//        [tabButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [tabView addSubview:tabButton];
        
        //设置标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 60, 15)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [tabTitle objectAtIndex:i];
        [tabView addSubview:titleLabel];
    }
    
    [tabBarView setHidden:YES];
}

////显示 隐藏tabbar
//- (void)tabbarbtn:(HEXCMyUIButton*)btn
//{
//    //在移动的时候不触发点击事件
//    if (!btn.MoveEnabled) {
//        if(!flag){
//            tabBarView.hidden = NO;
//            flag = YES;
//        }else{
//            tabBarView.hidden = YES;
//            flag = NO;
//        }
//    }


@end
