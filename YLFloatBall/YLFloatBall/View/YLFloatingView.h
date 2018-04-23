//
//  YLFloatingView.h
//  FloatingWindowDemo
//
//  Created by 于露 on 2018/3/12.
//  Copyright © 2018年 蒋永昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLFloatingView;
@protocol YLFloatingViewDelegate <NSObject>

- (void)YLFloatingViewButtonClick:(YLFloatingView *)floatView;
@end

@interface YLFloatingView : UIImageView
@property (nonatomic,weak) id<YLFloatingViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)imgUrl delegate:(id<YLFloatingViewDelegate>)delegate;

/**
 *  Show
 */
- (void)show;

/**
 *  Remove and dealloc
 */
- (void)removeFromScreen;
@end
