//
//  WKWebViewTwoViewController.m
//  WebViewLoadLocal
//
//  Created by gfy on 2018/3/20.
//  Copyright © 2018年 gfy. All rights reserved.
//

#import "WKWebViewTwoViewController.h"
@import WebKit;

@interface WKWebViewTwoViewController ()<WKNavigationDelegate>

@end

@implementation WKWebViewTwoViewController

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self aaaaaaa];
    
}
- (void)aaaaaaa
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *array1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *tmpPath = NSTemporaryDirectory();
    
//    NSString *matPath1 = [[array1 objectAtIndex:0] stringByAppendingPathComponent:@"web-mobile"];;
    NSString *matPath1 = [tmpPath stringByAppendingPathComponent:@"web-mobile"];;

    if (![fileManager fileExistsAtPath:matPath1]) {
        NSString *matString = [[NSBundle mainBundle] pathForResource:@"web-mobile" ofType:@"bundle"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [fileManager removeItemAtPath:matPath1 error:nil];
            
            [fileManager copyItemAtPath:matString toPath:matPath1 error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"呵呵  创建完了");
                if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
//                    [self testios8];
//                    [self testOne];
                    [self testios81];
                }
                else{
//                    [self testios9];
                    [self testOne];
//                    [self testTwo];
//                    [self testios81];

                }
            });
        });
    }
    else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] <9.0) {
//            [self testios8];
//            [self testOne];
            [self testios81];
            
        }
        else{
//            [self testios9];
            [self testOne];
//            [self testTwo];
//            [self testios81];
        }
    }
}

//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView82:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

- (void)testios81 {
//    NSString *matString = [[NSBundle mainBundle] pathForResource:@"web-mobile" ofType:@"bundle"];
    
//    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0 * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height -64 )];

    
  
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//
//    NSString *path = [paths objectAtIndex:0];
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *basePath = [NSString stringWithFormat:@"%@/%@",tmpPath,@"web-mobile/"];
    NSString *htmlPath = [basePath stringByAppendingPathComponent:@"index.html"];
    NSURL *fileURL = [self fileURLForBuggyWKWebView82:[NSURL fileURLWithPath:basePath]];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0 * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height -64 )];
    [webView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];

    webView.navigationDelegate = self;
    [self.view  addSubview:webView];
    NSString *JSON = [NSString stringWithFormat:@"?fileUrl=%@",@"http://ipsgame.speiyou.cn/resources/NumberString.json"];
    
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    NSURL *now = [NSURL URLWithString:JSON relativeToURL:url];
    [webView loadRequest:[NSURLRequest requestWithURL:now]];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"www/web-mobile/index.html"]]]]];
    return;
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSString *tmpPath = NSTemporaryDirectory();
//    NSString *basePath = [NSString stringWithFormat:@"%@%@",tmpPath,@"web-mobile/"];
//    NSString *htmlPath =  [NSString stringWithFormat:@"%@%@",tmpPath,@"web-mobile/index.html"];
//
//    //    NSString *JSON = [NSString stringWithFormat:@"?fileUrl=%@",@"http://ipsgame.speiyou.cn/resources/NumberString.json, Method GET, Headers {\"Upgrade-Insecure-Requests\" =     [1];}"];
//    NSString *JSON = [NSString stringWithFormat:@"?fileUrl=%@",@"http://ipsgame.speiyou.cn/resources/NumberString.json"];
//
//    NSURL *url = [NSURL fileURLWithPath:htmlPath];
//    NSURL *now = [NSURL URLWithString:JSON relativeToURL:url];
//    webView.navigationDelegate = self;
//    //    [webView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:now];
//    //    [request setHTTPMethod:@"GET"];
//    //    [request setValue:@"(1)" forHTTPHeaderField:@"Upgrade-Insecure-Requests"];
//
//    [webView loadRequest:request];
//
}
- (void)testios8 {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *basePath = [NSString stringWithFormat:@"%@/%@",path,@"QueHTML/"];
    NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:basePath]];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0 * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height -64 )];
    webView.navigationDelegate = self;
    [self.view  addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"www/QueHTML/123.html"]]]]];
    
    
    
    
}
- (void)testios9 {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *basePath = [NSString stringWithFormat:@"%@/%@",path,@"web-mobile/"];
    NSString *htmlPath =  [NSString stringWithFormat:@"%@/%@",path,@"web-mobile/index.html"];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0 * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) configuration:configuration];
    [webView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    
    webView.navigationDelegate = self;
    [self.view  addSubview:webView];
    NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadFileURL:fileURL allowingReadAccessToURL:[NSURL fileURLWithPath:basePath isDirectory:YES]];
    
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView  {
    
    NSLog(@"哈哈哈==== %@",webView.URL);
    [webView reload];
    
}

- (void)testTwo {
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    [configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0 * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) configuration:configuration];
    [self.view  addSubview:webView];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *basePath = [NSString stringWithFormat:@"%@/%@",path,@"web-mobile/"];
    NSString *htmlPath =  [NSString stringWithFormat:@"%@/%@",path,@"web-mobile/index.html"];

    
    NSURL *fileUrl = [NSURL fileURLWithPath:htmlPath isDirectory:NO];//此部分没有?所以没有问题，isDirectory=YES会导致多一层目录。
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:fileUrl resolvingAgainstBaseURL:NO];
    [urlComponents setQueryItems:@[ [NSURLQueryItem queryItemWithName:@"fileUrl" value:@"http://ipsgame.speiyou.cn/resources/NumberString.json"]]];
    
    
    webView.navigationDelegate = self;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:urlComponents.URL];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:now];
//    [request setHTTPMethod:@"GET"];
    //    [request setValue:@"(1)" forHTTPHeaderField:@"Upgrade-Insecure-Requests"];
    
    [webView loadRequest:request];
    
}
- (void)testOne {
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    [configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0 * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) configuration:configuration];
    [self.view  addSubview:webView];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *basePath = [NSString stringWithFormat:@"%@/%@",tmpPath,@"web-mobile/"];
    NSString *htmlPath =  [NSString stringWithFormat:@"%@/%@",tmpPath,@"web-mobile/index.html"];
    
//    NSString *JSON = [NSString stringWithFormat:@"?fileUrl=%@",@"http://ipsgame.speiyou.cn/resources/NumberString.json, Method GET, Headers {\"Upgrade-Insecure-Requests\" =     [1];}"];
    NSString *JSON = [NSString stringWithFormat:@"?fileUrl=%@",@"http://ipsgame.speiyou.cn/resources/NumberString.json"];

    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    NSURL *now = [NSURL URLWithString:JSON relativeToURL:url];
    webView.navigationDelegate = self;
//    [webView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:now];
    [webView loadRequest:request];
    

    
    
    //htmlPath即是本地html的路径，filename即是html名 NSString *filePath = [htmlPath stringByAppendingPathComponent:filename]; NSString *htmlString = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil]; [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];

    return;
    
    if(basePath){
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            // iOS9. One year later things are OK.
//            NSURL *fileURL = [NSURL fileURLWithPath:path];
//
//            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
//            [gameWebView loadRequest:request];

            [[NSURLCache sharedURLCache] removeAllCachedResponses];

            NSString * localPath = [NSString stringWithFormat:@"%@?fileUrl=%@",[basePath stringByAppendingPathComponent:@"index.html"],@"http://ips.web.speiyou.cn/stone-ips-web/json/stjson/gameQuestion/paper/tiku30/34958182f87644da9fa722e0582fa0f0.json"];

            localPath = [localPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSURL *gameUrl = [NSURL URLWithString:localPath];

            [webView loadFileURL:gameUrl allowingReadAccessToURL:nil];

         } else {
            // iOS8. Things can be workaround-ed
            //   Brave people can do just this
            //   fileURL = try! pathForBuggyWKWebView8(fileURL)
            //   webView.loadRequest(NSURLRequest(URL: fileURL))

            NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:path]];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [webView loadRequest:request];
        }
    }
    
    
    
}

//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

#pragma mark WKNavigationDelegate
/*! @abstract Decides whether to allow or cancel a navigation.
 @param webView The web view invoking the delegate method.
 @param navigationAction Descriptive information about the action
 triggering the navigation request.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationActionPolicy.
 @discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlStr =  navigationAction.request.URL.absoluteString;
    NSLog(@"urlStr1 = %@  scheme== %@",urlStr, navigationAction.request.URL.scheme);
    //    decisionHandler(WKNavigationActionPolicyAllow);
    
//    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
//    NSURL *url = navigationAction.request.URL;
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && [url.scheme isEqualToString:@"https"]) {
//        [[UIApplication sharedApplication] openURL:url];//手动跳转
//        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
//    }
//    else{
//        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
//    }
    decisionHandler(WKNavigationActionPolicyAllow);//允许跳转

    
}
- (void)gameJson {
    
    

    
}
/*! @abstract Decides whether to allow or cancel a navigation after its
 response is known.
 @param webView The web view invoking the delegate method.
 @param navigationResponse Descriptive information about the navigation
 response.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
 @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSString *urlStr =  navigationResponse.response.URL.absoluteString;
    NSLog(@"urlStr2 = %@",urlStr);
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}

/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSLog(@"%s",__func__);
}

/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s",__func__);
    
}

/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s ==Error= %@",__func__,error);
    
    if (error.code == 1) {
        return;
    }
    
}

/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSLog(@"%s",__func__);
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSLog(@"%s",__func__);
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%s ====Error=%@",__func__,error);
}

/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//
//
//}

/*! @abstract Invoked when the web view's web content process is terminated.
 @param webView The web view whose underlying web content process was terminated.
 */
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
//
//    NSLog(@"哈哈哈=== %@",webView.URL);
//}

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
