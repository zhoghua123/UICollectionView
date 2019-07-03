//
//  AppDelegate.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/9.
//  Copyright © 2017年 xyj. All rights reserved.
//
#import "CollectionViewController.h"
#import "AppDelegate.h"
#import "ZHMenuViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] init];
    window.frame = [UIScreen mainScreen].bounds;
//    window.rootViewController =[[CollectionViewController alloc] init];
    window.rootViewController = [[ZHMenuViewController alloc] init];
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

@end
