//
//  main.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/7.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    //return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
