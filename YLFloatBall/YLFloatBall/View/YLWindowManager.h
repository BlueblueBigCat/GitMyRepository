//
//  YLWindowManager.h
//  FloatingWindowDemo
//
//  Created by 于露 on 2018/3/12.
//  Copyright © 2018年 蒋永昌. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface YLWindowManager : NSObject
+ (instancetype)shared;

/**
 *  Get UIWindow based on key value
 *
 *  @param key key
 *
 *  @return window
 */
+ (UIWindow *)windowForKey:(NSString *)key;

/**
 *  Save a window and set the key
 *
 *  @param window window
 *  @param key    key
 */
+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key;

/**
 *  Destroy a window according to key
 *
 *  @param key       key
 */
+ (void)destroyWindowForKey:(NSString *)key;

/**
 *  Destroy all window
 */
+ (void)destroyAllWindow;
@end
