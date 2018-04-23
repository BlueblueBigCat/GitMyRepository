//
//  PrefixHeader.h
//  sphereScaleProject
//
//  Created by 于露 on 2018/4/23.
//  Copyright © 2018年 于露. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h
// 判断是否iphoneX
#define Is_IphoneX  SCREEN_HEIGHT >= 812
#define SMALLWIDTH ((Is_IphoneX)?90: 60)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define IOS_VERSION_11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#endif /* PrefixHeader_h */
