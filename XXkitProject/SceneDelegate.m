//
//  SceneDelegate.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/5.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "SceneDelegate.h"

@implementation SceneDelegate
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)){
    [self createNavigationWithIntitalViewControllerAtStoryboard:@"Main" bundle:[NSBundle mainBundle]];
}
@end
