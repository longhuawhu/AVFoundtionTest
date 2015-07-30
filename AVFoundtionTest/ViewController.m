//
//  ViewController.m
//  AVFoundtionTest
//
//  Created by lh on 15/7/30.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "ViewController.h"
#import "GetQRCodeViewController.h"
#import "GeneragteQrCodeViewController.h"

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
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 80, 44)];
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"生成二维码" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];

}

-(void)btnAction{
    GetQRCodeViewController *vc = [[GetQRCodeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)btnAction1{
    GeneragteQrCodeViewController *vc = [[GeneragteQrCodeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
