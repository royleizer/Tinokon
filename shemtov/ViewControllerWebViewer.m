//
//  ViewControllerWebViewer.m
//  shemtov
//
//  Created by Roy Leizer on 19/06/2022.
//  Copyright © 2022 Roy Leizer. All rights reserved.
//

#import "ViewControllerWebViewer.h"
#import <WebKit/WebKit.h>

@interface ViewControllerWebViewer ()

@property (weak, nonatomic) IBOutlet WKWebView *myWebView;

@end

@implementation ViewControllerWebViewer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @try
    {
    NSString * myURL=[[NSString stringWithFormat: @"%@", self.url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    webView.navigationDelegate = self;
    NSURL *nsurl=[NSURL URLWithString:myURL];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    [self.view addSubview:webView];
    }
    @catch(NSException * ex)
    {
        NSLog(@"EXCEPTION: %@",ex);
    }
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
