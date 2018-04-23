//
//  ScrollImageView.h
//  ScrollImageProject
//  自滚动图片控件
//  Created by 于露 on 2018/4/23.
//  Copyright © 2018年 于露. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollImageView : UIView
- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSMutableArray *)imgArr;
- (void)reloadScrollImageViewWithArr:(NSMutableArray *)imageArr;
-(void)reBegin;
-(void)stop;
@end
