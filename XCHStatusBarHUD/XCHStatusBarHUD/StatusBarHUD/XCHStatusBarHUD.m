//
//  XCHStatusBarHUD.m
//  XCHStatusBarHUD
//
//  Created by xuech on 16/5/9.
//  Copyright © 2016年 obizsoft. All rights reserved.
//

#import "XCHStatusBarHUD.h"
#define MessageFont [UIFont systemFontOfSize:12]
/** 消息的停留时间 */
static CGFloat const MessageDuration = 2.0;
/** 消息显示\隐藏的动画时间 */
static CGFloat const AnimationDuration = 0.25;

@implementation XCHStatusBarHUD

static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;


+(void)showWindow{
    CGRect frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20);
    window_.hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = frame;
    window_.hidden = NO;
    
    frame.origin.y = 0;
    [UIView animateWithDuration:AnimationDuration animations:^{
        window_.frame = frame;
    }];
}

+ (void)showMessage:(NSString *)msg image:(UIImage *)image{
    
    [timer_ invalidate];
    
    [self showWindow];
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:msg forState:UIControlStateNormal];
    button.titleLabel.font = MessageFont;
    if (image) { // 如果有图片
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    button.frame = window_.bounds;
    [window_ addSubview:button];
    
    // 定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:MessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hide];
//    });
}
/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg{
    [self showMessage:msg image:nil];
}

/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg{
    [self showMessage:msg image:[UIImage imageNamed:@"XCHStatusBarHUD.bundle/success"]];
}
/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg{
    [self showMessage:msg image:[UIImage imageNamed:@"XCHStatusBarHUD.bundle/error"]];
}
/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg{
    [timer_ invalidate];
    timer_ = nil;
    
    // 显示窗口
    [self showWindow];
    
    // 添加文字
    UILabel *label = [[UILabel alloc] init];
    label.font = MessageFont;
    label.frame = window_.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    [window_ addSubview:label];
    
    // 添加圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    // 文字宽度
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName : MessageFont}].width;
    CGFloat centerX = (window_.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];

}
/**
 * 隐藏
 */
+ (void)hide{
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y =  - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}
@end
