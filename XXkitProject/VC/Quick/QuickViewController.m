//
//  QuickViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/10/14.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "QuickViewController.h"
#import "../../../../XXkit/Object-C/Quick/UIViewController+QuickLoader.h"

@interface QuickViewController ()
@end

@implementation QuickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self quick_loadFromFileName:@"Quick.json" bundle:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
