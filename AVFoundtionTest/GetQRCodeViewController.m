//
//  GetQRCodeViewController.m
//  AVFoundtionTest
//
//  Created by lh on 15/7/30.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "GetQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface GetQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property ( strong , nonatomic ) AVCaptureDevice * device;
@property ( strong , nonatomic ) AVCaptureDeviceInput * input;
@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;
@property ( strong , nonatomic ) AVCaptureSession * session;
@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * preview;


@end

@implementation GetQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫描二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo ];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice: self.device error: nil ];
    // Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    
    [_output setMetadataObjectsDelegate:self queue: dispatchQueue];
    // Session
    _session = [[AVCaptureSession alloc] init ];
    [_session setSessionPreset: AVCaptureSessionPresetHigh];
    if ([_session canAddInput : self.input ])
    {
        [ _session addInput: self.input ];
    }
    if ([ _session canAddOutput: self.output ])
    {
        [ _session addOutput : self.output ];
    }
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode] ;
    
    
    CGRect cropRect = CGRectMake(60, 200, 200, 200);
    
    CGSize size = self.view.bounds.size;
    
    _output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                        
                                        cropRect.origin.x/size.width,
                                        
                                        cropRect.size.height/size.height,
                                        
                                        cropRect.size.width/size.width);
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session ];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    
    _preview.frame = self.view.layer.bounds ;

    _preview.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer insertSublayer: _preview atIndex: 0 ];
    
    [self addCovetExceptRect:cropRect inSupeLayer:_preview];
   
    // Start
    [_session startRunning ];
}

-(void)addCovetExceptRect:(CGRect)rect inSupeLayer:(CALayer *)superlayer{
    
    CGRect rect1 = CGRectMake(0, 0, superlayer.bounds.size.width, rect.origin.y);
    
    CGRect rect2 = CGRectMake(0, rect.origin.y, rect.origin.x, rect.size.height);
    
    CGRect rect3 = CGRectMake(rect.origin.x + rect.size.width, rect.origin.y, superlayer.bounds.size.width - rect.origin.x - rect.size.width, rect.size.height);
    
    CGRect rect4 = CGRectMake(0, rect.origin.y + rect.size.height, superlayer.bounds.size.width, superlayer.bounds.size.height - rect.origin.y - rect.size.height);
    
    [self addCoverLayerWithRect:rect1 inSupeLayer:superlayer];
    [self addCoverLayerWithRect:rect2 inSupeLayer:superlayer];
    [self addCoverLayerWithRect:rect3 inSupeLayer:superlayer];
    [self addCoverLayerWithRect:rect4 inSupeLayer:superlayer];
}

-(void)addCoverLayerWithRect:(CGRect) rect inSupeLayer:(CALayer *)superlayer{
    
    CALayer *whiteLayer = [CALayer layer];
    
    whiteLayer.frame = rect;
    
    whiteLayer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    
    //add it to our view
    
    [superlayer addSublayer:whiteLayer];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- ( void )captureOutput:( AVCaptureOutput *)captureOutput didOutputMetadataObjects:( NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] > 0 )
    {
        // 停止扫描
        [ _session stopRunning ];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        stringValue = metadataObject.stringValue ;
        NSLog(@"result: %@", stringValue);
        
      //  [_preview removeFromSuperlayer];
        
    }
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
