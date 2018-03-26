//
//  IphoneXViewController.m
//  WebViewLoadLocal
//
//  Created by gfy on 2018/3/22.
//  Copyright © 2018年 gfy. All rights reserved.
//

#import "IphoneXViewController.h"
#import "Masonry.h"
@import WebKit;
@interface IphoneXViewController ()

@end

@implementation IphoneXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    Class wkWebViewClass = NSClassFromString(@"WKWebView");
    
//
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ipsgame.speiyou.cn/Math/Winner2017/NumberString/index.html?v=1519791063811&fileUrl=http://ipsgame.speiyou.cn/resources/NumberString.json&platform=undefined"]]];
////    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
////    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ipsgame.speiyou.cn"]]];
//
//    [self.view addSubview:webView];
//    if (@available(iOS 11.0, *)) {
//
//        webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//
//    }

    
    WKWebView *wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ipsgame.speiyou.cn/Math/Winner2017/NumberString/index.html?v=1519791063811&fileUrl=http://ipsgame.speiyou.cn/resources/NumberString.json&platform=undefined"]]];
    [self.view addSubview:wkWebView];
//
    
    if (@available(iOS 11.0, *)) {

        wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    }
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
