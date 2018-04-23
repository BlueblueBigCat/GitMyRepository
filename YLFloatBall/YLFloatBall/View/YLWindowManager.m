//
//  YLWindowManager.m
//  FloatingWindowDemo
//
//  Created by 于露 on 2018/3/12.
//  Copyright © 2018年 蒋永昌. All rights reserved.
//

#import "YLWindowManager.h"
@interface YLWindowManager ()
/** save windows dictionary */
@property (nonatomic, strong) NSMutableDictionary *windowDic;

@end

@implementation YLWindowManager
static YLWindowManager *_instance;
+ (instancetype)shared
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}


+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark - getter
- (NSMutableDictionary *)windowDic
{
    if (!_windowDic) {
        _windowDic = [NSMutableDictionary dictionary];
    }
    return _windowDic;
}

#pragma mark - public methods

+ (UIWindow *)windowForKey:(NSString *)key
{
    return [[YLWindowManager shared].windowDic objectForKey:key];
}

+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key
{
    [[YLWindowManager shared].windowDic setObject:window forKey:key];
}

+ (void)destroyWindowForKey:(NSString *)key
{
    UIWindow * window = [[YLWindowManager shared].windowDic objectForKey:key];
    window.hidden = YES;
    if (window.rootViewController.presentedViewController) {
        // 删除展示的vc
        [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    // 展示的vc置空
    window.rootViewController = nil;
    [[YLWindowManager shared].windowDic removeObjectForKey:key];
}

+ (void)destroyAllWindow
{
    for (UIWindow *window in [YLWindowManager shared].windowDic.allValues) {
        window.hidden = YES;
        window.rootViewController = nil;
    }
    [[YLWindowManager shared].windowDic removeAllObjects];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}
@end
