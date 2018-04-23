//
//  ViewController.m
//  sphereScaleProject
//
//  Created by 于露 on 2018/4/23.
//  Copyright © 2018年 于露. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    CGRect orginFrame; // 原始frame
    UIImageView * tempView; // 顶部view
}
@property (nonatomic,weak) UIImageView * plantImgView; // 星球图片
@property (nonatomic, assign) CGFloat lastcontentOffset; // 记录滚动位置
@end

@implementation ViewController

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
    
    UIScrollView * mainScrollV = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainScrollV.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*1.4+SCREEN_WIDTH*0.51*7);
    mainScrollV.delegate = self;
    [self.view addSubview:mainScrollV];
    
    if (IOS_VERSION_11)
    {
        // 安全区调整
        if ([mainScrollV respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            mainScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    // 星球图片
   UIImageView * plantImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0 , SCREEN_WIDTH * 0.06, SCREEN_WIDTH, SCREEN_WIDTH)];
    plantImgV.contentMode = UIViewContentModeScaleToFill;
    plantImgV.image = [UIImage imageNamed:@"home_astro_00"];
    [mainScrollV addSubview:plantImgV];
    self.plantImgView = plantImgV;
    
    orginFrame = plantImgV.frame;
}

#pragma mark -- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    CGFloat offY = point.y - self.lastcontentOffset;
    //    NSLog(@"-----point.y=%f",point.y);
    self.lastcontentOffset = point.y;
    if (offY > 0) {
        
        if (self.plantImgView.frame.size.height> SMALLWIDTH && point.y>0) {
            // 缩小
            CGFloat scale = (1- fabs(offY)/self.plantImgView.frame.size.width);
            
            // 图片缩小
            self.plantImgView.transform = CGAffineTransformScale(self.plantImgView.transform, scale, scale);
            // 透明度设置
            self.plantImgView.alpha = self.plantImgView.frame.size.width/SCREEN_WIDTH;
            if (self.plantImgView.frame.origin.y>orginFrame.origin.y&&self.plantImgView.frame.size.height<orginFrame.size.height) {
                CGRect rect = self.plantImgView.frame;
                rect.origin.y =  SCREEN_WIDTH + orginFrame.origin.y - self.plantImgView.frame.size.height;
                self.plantImgView.frame = rect;
            }else
            {
                self.plantImgView.transform = CGAffineTransformTranslate(self.plantImgView.transform, 0,offY);
            }
        }else
        {
            // 到达指定位置，展示tempView
            if (!tempView&&self.plantImgView.frame.size.height<= SMALLWIDTH) {
                if (self.plantImgView==nil) {
                    return;
                }
                
                tempView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SMALLWIDTH+ orginFrame.origin.y)];
                tempView.image = [UIImage imageNamed:@"match_radiusImg_xp"];
                [self.view addSubview:tempView];
                
                UIImageView * bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-SMALLWIDTH/3, orginFrame.origin.y, SMALLWIDTH/3*2, SMALLWIDTH/3*2)];
                
                if (Is_IphoneX) {
                    bgImgV.frame = CGRectMake(SCREEN_WIDTH/2-SMALLWIDTH * 0.22, orginFrame.origin.y + SMALLWIDTH/3, SMALLWIDTH* 0.44, SMALLWIDTH *0.44);
                }
              
                bgImgV.image = [UIImage imageNamed:@"home_astroSmall_00"];
                [tempView addSubview:bgImgV];
            }
        }
        
    }else{
        // 图片放大
        if (scrollView.contentOffset.y<= SCREEN_WIDTH) {
            if (self.plantImgView.frame.size.height>= orginFrame.size.height) {
                
                self.plantImgView.transform = CGAffineTransformMakeScale(1, 1);
                self.plantImgView.alpha = 1;
                self.plantImgView.frame = orginFrame;
            }else
            {
                //移除tempView
                if (point.y< SCREEN_WIDTH -tempView.frame.size.height) {
                    if (tempView) {
                        [tempView removeFromSuperview];
                        tempView = nil;
                    }
                    // 放大
                    CGFloat scale = (1+ fabs(offY)/self.plantImgView.frame.size.width);
                    CGFloat alphValue = self.plantImgView.frame.size.width/SCREEN_WIDTH;
                    
                    // 透明度设置
                    self.plantImgView.alpha = alphValue;
                    
                    // 图片放大
                    self.plantImgView.transform = CGAffineTransformTranslate(self.plantImgView.transform, 0, offY);
                    self.plantImgView.transform = CGAffineTransformScale(self.plantImgView.transform, scale, scale);
                }
                
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
