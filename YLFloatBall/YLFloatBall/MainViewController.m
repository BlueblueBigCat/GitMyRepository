//
//  MainViewController.m
//  YLFloatBall
//
//  Created by 于露 on 2018/4/23.
//  Copyright © 2018年 于露. All rights reserved.
//
#define LiveWindow_Key @"liveWindow"

#import "YLCircleWindow.h"
#import "LiveChatRoomViewController.h"
#import "YLWindowManager.h"
#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

#pragma mark -- 初始化UI
-(void)initUI
{
    UIView * view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    [btn setTitle:@"创建悬可收起VC" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(createFloatBallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark -- 创建悬浮球
- (void)createFloatBallButtonClicked:(id)sender
{
    // 创建window
    if ([YLWindowManager windowForKey:LiveWindow_Key]) return;
    
    LiveChatRoomViewController * liveVC = [[LiveChatRoomViewController alloc] init];
    
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    YLCircleWindow * window = [[YLCircleWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:liveVC];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
    
    // 保存
    [YLWindowManager saveWindow:window forKey:LiveWindow_Key];
    [currentKeyWindow makeKeyWindow];
    
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
