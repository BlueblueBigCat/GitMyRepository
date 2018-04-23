//
//  LiveChatRoomViewController.m
//  YLFloatBall
//
//  Created by 于露 on 2018/4/23.
//  Copyright © 2018年 于露. All rights reserved.
//
#define LiveWindow_Key @"liveWindow"
#import "YLWindowManager.h"
#import "YLFloatingView.h"
#import "LiveChatRoomViewController.h"

@interface LiveChatRoomViewController ()<YLFloatingViewDelegate>
@property (nonatomic,weak) YLFloatingView * floatView;
@end

@implementation LiveChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

#pragma mark -- 初始化ui
- (void)initUI
{
    UIView * view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    // 收起
    UIButton * hangUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [hangUpBtn setTitle:@"收起" forState:UIControlStateNormal];
    [hangUpBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [hangUpBtn setBackgroundColor:[UIColor redColor]];
    [hangUpBtn addTarget:self action:@selector(hangUpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hangUpBtn];
    
    // 退出
    UIButton * quitBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    [quitBtn setTitle:@"退出" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [quitBtn setBackgroundColor:[UIColor redColor]];
    [quitBtn addTarget:self action:@selector(quitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitBtn];
}

#pragma mark -- 收起
- (void)hangUpButtonClicked:(id)sender
{
    CGFloat btnWidth = 70;
    YLFloatingView* fView = [[YLFloatingView alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnWidth) image:@"http://192.168.1.201:8086/vimg/icon/1/14344e79-fcropped_1516707829228.jpg" delegate:self];
    [fView show];
    self.floatView = fView;
}

#pragma mark -- 退出
- (void)quitButtonClicked:(id)sender
{
     [YLWindowManager destroyWindowForKey:LiveWindow_Key];
}

#pragma mark -- YLFloatingViewDelegate
- (void)YLFloatingViewButtonClick:(YLFloatingView *)floatView
{
    if (![YLWindowManager windowForKey:LiveWindow_Key]) return;
    
    UIWindow * w1 = [YLWindowManager windowForKey:LiveWindow_Key];
    
    [UIView animateWithDuration:0.5 animations:^{
        w1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        w1.layer.cornerRadius = 35;
        w1.layer.masksToBounds = YES;
        
        [self.floatView removeFromScreen];
        
    } completion:^(BOOL finished) {
        w1.layer.cornerRadius = 0;
        w1.layer.masksToBounds = YES;
    }];
    
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
