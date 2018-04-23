//
//  YLFloatingView.m
//  FloatingWindowDemo
//
//  Created by 于露 on 2018/3/12.
//  Copyright © 2018年 蒋永昌. All rights reserved.
//
#define LiveWindow_Key @"liveWindow"

#import <UIImageView+WebCache.h>
#import "YLWindowManager.h"
#import "YLFloatingView.h"

@implementation YLFloatingView
- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)imgUrl delegate:(id<YLFloatingViewDelegate>)delegate
{
    if(self = [super initWithFrame:frame])
    {
        self.delegate = delegate;
        self.userInteractionEnabled = YES;
        
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.borderWidth = 3;
        [self sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder_btn_gir"]];

        // 添加拖拽手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        
        // 添加点击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTaped:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - event response
- (void)handlePanGesture:(UIPanGestureRecognizer*)p
{
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panPoint = [p locationInView:appWindow];
    
    if(p.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1;
    }else if(p.state == UIGestureRecognizerStateChanged) {
        [YLWindowManager windowForKey:LiveWindow_Key].center = CGPointMake(panPoint.x, panPoint.y);
    }else if(p.state == UIGestureRecognizerStateEnded
             || p.state == UIGestureRecognizerStateCancelled) {
        self.alpha = 1;
        
        CGFloat ballWidth = self.frame.size.width;

        CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kScreenHeight =  [UIScreen mainScreen].bounds.size.height;
        CGPoint newCenter = CGPointZero;
        
        if(panPoint.x <= kScreenWidth/2)
        {
            // test
            if (panPoint.y <= 64) {
                  newCenter  = CGPointMake(ballWidth/2, 64);
            }else if (panPoint.y >= kScreenHeight - 75)
            {
                 newCenter = CGPointMake(ballWidth/2, kScreenHeight - 75);
            }else
            {
                newCenter = CGPointMake(ballWidth/2, panPoint.y);
            }
        }
        else
        {
            // test
            if (panPoint.y <= 64) {
              
                newCenter = CGPointMake(kScreenWidth - ballWidth/2, 64);
            }else if (panPoint.y >= kScreenHeight - 75)
            {
                newCenter = CGPointMake(kScreenWidth - ballWidth/2, kScreenHeight - 75);
            }else
            {
                 newCenter = CGPointMake(kScreenWidth - ballWidth/2, panPoint.y);
            }
        }
        
        [UIView animateWithDuration:.25 animations:^{
            [YLWindowManager windowForKey:LiveWindow_Key].center = newCenter;
        }];
    }else{
        NSLog(@"pan state : %zd", p.state);
    }
}

- (void)tapGestureTaped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(YLFloatingViewButtonClick:)])
    {
        [self.delegate YLFloatingViewButtonClick:self];
    }
}

#pragma mark - public methods
// 添加并保存和展示window
- (void)show
{
    if (![YLWindowManager windowForKey:LiveWindow_Key]) return;
    
    UIWindow * window= [YLWindowManager windowForKey:LiveWindow_Key] ;
    
    [UIView animateWithDuration:0.5 animations:^{
        window.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - self.frame.size.width, 64, self.frame.size.width, self.frame.size.height);
        window.layer.cornerRadius = self.frame.size.width/2;
        window.layer.masksToBounds = YES;
    } completion:^(BOOL finished) {
        [window addSubview:self];
    }];
    
}

- (void)removeFromScreen
{
    [self removeFromSuperview];
}
@end
