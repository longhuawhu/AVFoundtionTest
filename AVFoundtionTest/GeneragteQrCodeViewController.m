//
//  GeneragteQrCodeViewController.m
//  AVFoundtionTest
//
//  Created by lh on 15/7/30.
//  Copyright © 2015年 lh. All rights reserved.
//

#import "GeneragteQrCodeViewController.h"


@interface GeneragteQrCodeViewController ()
@property (nonatomic, weak)UITextField *tf;
@property (nonatomic, weak)UIImageView *imageView;
@property (nonatomic, weak)UIButton *btn;
@end

@implementation GeneragteQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"生成二维码";
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 44)];
    [self.view addSubview:tf];
    tf.placeholder = @"输入要转换的字符串";
    _tf = tf;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 300, 100, 100)];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor blueColor];
    _imageView = imageView;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 100, 44)];
    [self.view addSubview:btn];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//http://www.bkjia.com/Androidjc/1022994.html
-(void)btnAction{
    [self.view endEditing:YES];
    NSString *qrString = _tf.text;
    if([qrString length] == 0){
        return;
    }
    
    NSData *date = [qrString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:date forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *image = qrFilter.outputImage;
    
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    
    [colorFilter setValue:image forKey:@"inputImage"];
    [colorFilter setValue:[[CIColor alloc] initWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]] forKey:@"inputColor0"];
    [colorFilter setValue:[[CIColor alloc] initWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]] forKey:@"inputColor1"];
    
    UIImage *codeImage = [[UIImage alloc] initWithCIImage:[colorFilter.outputImage imageByApplyingTransform:CGAffineTransformMakeScale(5, 5)]];
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    
    UIGraphicsBeginImageContext(rect.size);
    [codeImage drawInRect:rect];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    _imageView.image = resultImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
