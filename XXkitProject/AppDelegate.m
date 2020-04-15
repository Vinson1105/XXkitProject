//
//  AppDelegate.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/7.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "AppDelegate.h"
#import "./MainViewController.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    [self createNavigationWithUIStoryboard:@"Main" bundle:nil];
    return YES;
}
@end
