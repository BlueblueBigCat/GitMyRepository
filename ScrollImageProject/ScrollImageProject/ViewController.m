//
//  ViewController.m
//  ScrollImageProject
//
//  Created by 于露 on 2018/4/23.
//  Copyright © 2018年 于露. All rights reserved.
//

#import "ScrollImageView.h"
#import "ViewController.h"

@interface ViewController ()
{
    ScrollImageView * scrollImgV;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
//    [self initUI];
    [self test1];
}

- (void)initUI
{
    scrollImgV = [[ScrollImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width) imgArray:nil];
    [scrollImgV reloadScrollImageViewWithArr:@[@"http://192.168.1.201:8086/vimg/icon/1/ec9ea14a-dcropped_1516707819104.jpg",@"http://192.168.1.201:8086/vimg/icon/1/e2b95972-ecropped_1516707838035.jpg"]];
    [self.view addSubview:scrollImgV];
    [scrollImgV reBegin];
    
}

- (void)test1
{
    scrollImgV = [[ScrollImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width) imgArray:@[@"http://192.168.1.201:8086/vimg/icon/1/ec9ea14a-dcropped_1516707819104.jpg",@"http://192.168.1.201:8086/vimg/icon/1/e2b95972-ecropped_1516707838035.jpg"]];
    [self.view addSubview:scrollImgV];
    [scrollImgV reBegin];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scrollImgV reloadScrollImageViewWithArr:@[@"http://192.168.1.201:8086/vimg/icon/1/14344e79-fcropped_1516707829228.jpg",@"http://192.168.1.201:8086/vimg/icon/1/16819d40-6cropped_1516707838035.jpg",@"http://192.168.1.201:8086/vimg/icon/1/ec9ea14a-dcropped_1516707819104.jpg"]];
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (scrollImgV) {
        [scrollImgV stop];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (scrollImgV) {
        [scrollImgV reBegin];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
