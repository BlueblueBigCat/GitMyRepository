//
//  YLCircleWindow.m
//  StarPlateProject
//
//  Created by 于露 on 2018/3/12.
//  Copyright © 2018年 于露. All rights reserved.
//

#import "YLCircleWindow.h"

@implementation YLCircleWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.windowLevel = 1000000;
        self.windowLevel = UIWindowLevelStatusBar-1;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
