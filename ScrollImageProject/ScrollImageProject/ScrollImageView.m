//
//  ScrollImageView.m
//  ScrollImageProject
//
//  Created by 于露 on 2018/4/23.
//  Copyright © 2018年 于露. All rights reserved.
//
#import <UIImageView+WebCache.h>
#import "ScrollImageView.h"
@interface ScrollImageView()<UIScrollViewDelegate>
{
    UIScrollView * scrollImgView;
    UIPageControl * pageControl;
    NSMutableArray * imgsArr; // 图片url
    NSTimer *imageTimer;
}
@end
@implementation ScrollImageView
- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSMutableArray *)imgArr
{
    if (self = [super initWithFrame:frame]) {
        imgsArr = [NSMutableArray array];
        imgsArr = imgArr;
        
        [self initUI];
    }
    return self;
}

#pragma mark -- 初始化ui
- (void)initUI
{
    scrollImgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollImgView.showsVerticalScrollIndicator = NO;
    scrollImgView.showsHorizontalScrollIndicator = NO;
    scrollImgView.delegate = self;
    scrollImgView.contentSize = CGSizeMake(imgsArr.count==0?1:(imgsArr.count+1) * self.frame.size.width, self.frame.size.height);
    scrollImgView.pagingEnabled = YES;
    [self addSubview:scrollImgView];
    
    [self loadDatas];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/4, self.frame.size.height - 25, self.frame.size.width/2, 20)];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.numberOfPages = imgsArr.count;
    [self addSubview:pageControl];
}

#pragma mark -- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (imageTimer) {
        int index = (int)scrollView.contentOffset.x/(int)self.frame.size.width;
        if (index == imgsArr.count) {
            scrollView.contentOffset = CGPointZero;
        }
        pageControl.currentPage = (int)scrollView.contentOffset.x/(int)self.frame.size.width;
    }else
    {
        CGPoint point = scrollView.contentOffset;
        
        pageControl.currentPage = (point.x + self.frame.size.width /2)/self.frame.size.width ;
    }
}

#pragma mark -- 重载图片
- (void)reloadScrollImageViewWithArr:(NSMutableArray *)imageArr
{
    if (imageArr.count > 0) {
        imgsArr = imageArr;
        
         scrollImgView.contentSize = CGSizeMake((imgsArr.count+1) * self.frame.size.width, self.frame.size.height);
        
        [self loadDatas];
        
        [scrollImgView bringSubviewToFront:pageControl];
        
        pageControl.numberOfPages = imgsArr.count;
    }
}

#pragma mark -- 数据
- (void)loadDatas
{
    for (UIImageView * imgV in scrollImgView.subviews) {
        if (imgV) {
            [imgV removeFromSuperview];
        }
    }
    
    for (int i=0; i<= imgsArr.count; i++) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
        
        if (i == imgsArr.count) {
            imgView.contentMode = UIViewContentModeScaleToFill;
            [imgView sd_setImageWithURL:[NSURL URLWithString:[imgsArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"regist_fillMessage_defaultIcon"]];
        }else
        {
            imgView.contentMode = UIViewContentModeScaleToFill;
            [imgView sd_setImageWithURL:[NSURL URLWithString:[imgsArr objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"regist_fillMessage_defaultIcon"]];
        }
        [scrollImgView addSubview:imgView];
    }
}


#pragma mark -- 启动timer
-(void)reBegin
{
    //设置滚动广告
    pageControl.currentPage = 0;
    scrollImgView.contentOffset = CGPointZero;
    if (!imageTimer) {
        imageTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(imageIdScroll:) userInfo:nil repeats:YES];
    }
}

#pragma mark -- 停止滚动
-(void)stop
{
    if (imageTimer) {
        [imageTimer invalidate];
        imageTimer = nil;
    }
}

#pragma mark -- 开始滚动
-(void)imageIdScroll:(NSTimer*)timer
{
    int index = (int)scrollImgView.contentOffset.x/(int)self.frame.size.width;
    [scrollImgView scrollRectToVisible:CGRectMake(self.frame.size.width*(index+1), 0, self.frame.size.width, self.frame.size.height) animated:YES];
}
@end
