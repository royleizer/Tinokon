//
//  ViewControllerWebview.m
//  shemtov
//
//  Created by Roy Leizer on 27/08/2018.
//  Copyright © 2018 Roy Leizer. All rights reserved.
//

#import "ViewControllerWebview.h"

@interface ViewControllerWebview ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pbPleaseWait;

@end

@implementation ViewControllerWebview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.url);
    
    //NSURL *address = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]];
    
    self.myWebView.delegate=self;
    
    
    NSString * myURL=[[NSString stringWithFormat: @"%@", self.url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *address = [NSURL URLWithString:myURL];
  
    NSURLRequest * requestObj = [NSURLRequest requestWithURL:address];
    [self.myWebView loadRequest:requestObj];
 
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.pbPleaseWait startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
     [self.pbPleaseWait stopAnimating];
    self.pbPleaseWait.hidesWhenStopped=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
