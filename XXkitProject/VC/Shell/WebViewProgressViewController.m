//
//  WebViewProgressViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/22.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "WebViewProgressViewController.h"
#import "../../../../XXkit/Objective-C/Shell/XXwebViewProgressShell.h"

@interface WebViewProgressViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic,strong) XXwebViewProgressShell *shell;
@end

@implementation WebViewProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shell = [XXwebViewProgressShell new];
    [_shell shell:_webView progress:_progressView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    [_shell request:url];
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
