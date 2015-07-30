//
//  ViewController.m
//  AVFoundtionTest
//
//  Created by lh on 15/7/30.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "ViewController.h"
#import "GetQRCodeViewController.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

-(void)btnAction{
    GetQRCodeViewController *vc = [[GetQRCodeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
