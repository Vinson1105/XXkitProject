//
//  AppDelegate.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/7.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "AppDelegate.h"
#import "./MainViewController.h"
#import "../../XXkit/Objective-C/Quick/QuickLoader.h"
#import "../../XXkit/Objective-C/Utility/XXdebugHelper.h"

#define Main
//#define XXAPP

#ifdef Main
#define kMainStoryboard @"Main"

#elif defined XXAPP
#define kMainStoryboard @"XXAPP"
#endif

//#define kMainStoryboard @"Main"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
#ifdef XXAPP
    [QuickLoader setMainQuickDataWithFileName:@"XXAPP.json" bundle:nil];
#endif
    [self createNavigationWithIntitalViewControllerAtStoryboard:kMainStoryboard bundle:nil];

    [XXdebugHelper install:[UIApplication sharedApplication].delegate.window];
    return YES;
}
@end
