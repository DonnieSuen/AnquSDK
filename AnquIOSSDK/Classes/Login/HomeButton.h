//
//  HomeButton.h
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeButton : UIButton{
    UIButton *imageBt;
    UILabel *label;
}

@property(nonatomic, strong)UIButton *imageBt;

@property(nonatomic, strong)UILabel *label;

@end
