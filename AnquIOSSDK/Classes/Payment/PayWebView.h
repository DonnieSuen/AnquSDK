//
//  PayWebView.h
//  anquFramework
//
//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"
#import "MBProgressHUD.h"

@interface PayWebView : UIViewController<UIWebViewDelegate>

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *anquPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UIWebView *webView;

//分割线
@property(nonatomic, strong)UIImageView *anquSplitLine;

@property(nonatomic, assign)int payway;

@property(nonatomic, strong)NSString *webUrl;

@property(nonatomic,strong)MBProgressHUD *HUD;

@end
