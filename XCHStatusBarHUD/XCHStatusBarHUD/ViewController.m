//
//  ViewController.m
//  XCHStatusBarHUD
//
//  Created by xuech on 16/5/9.
//  Copyright © 2016年 obizsoft. All rights reserved.
//

#import "ViewController.h"
#import "XCHStatusBarHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [XCHStatusBarHUD showSuccess:@"success"];
//    [XCHStatusBarHUD showLoading:@"加载中..."];
}

@end
