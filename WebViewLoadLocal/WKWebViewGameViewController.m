//
//  WKWebViewGameViewController.m
//  WebViewLoadLocal
//
//  Created by gfy on 2018/3/19.
//  Copyright © 2018年 gfy. All rights reserved.
//

#import "WKWebViewGameViewController.h"
@import WebKit;

@interface WKWebViewGameViewController ()<WKNavigationDelegate>

@end

@implementation WKWebViewGameViewController

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self aaaaaaa];
    
}
-(void)aaaaaaa
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *array1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *matPath1 = [[array1 objectAtIndex:0] stringByAppendingPathComponent:@"web-mobile"];;
    if (![fileManager fileExistsAtPath:matPath1]) {
        NSString *matString = [[NSBundle mainBundle] pathForResource:@"web-mobile" ofType:@"bundle"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [fileManager removeItemAtPath:matPath1 error:nil];
            
            [fileManager copyItemAtPath:matString toPath:matPath1 error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"呵呵  创建完了");
                if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                    [self testios8];
                }
                else{
                    [self testios9];
                }
            });
        });
    }
    else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] <9.0) {
            [self testios8];
        }
        else{
            [self testios9];
        }
    }
}


- (void)testios8 {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *basePath = [NSString stringWithFormat:@"%@/%@",path,@"web-mobile/"];
    NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:basePath]];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0 * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height -64 )];
    //    webView.layer.cornerRadius = 1.0f;
    //    webView.layer.borderColor = [UIColor redColor].CGColor;
    //    webView.layer.borderWidth = 2.0f;
    webView.navigationDelegate = self;
    [self.view  addSubview:webView];
//    [webView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"www/web-mobile/index.html"]]]]];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",basePath,@"index.html"]]]];
    
    
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
    webView.tag = 100;
    
    NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadFileURL:fileURL allowingReadAccessToURL:[NSURL fileURLWithPath:basePath isDirectory:YES]];
    
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
    NSURL *url  = navigationAction.request.URL;
    if ([url.scheme isEqualToString:@"optionblank"]) {
        NSString *methodString = url.host;
        if (methodString.length > 0)
        {
            methodString = [methodString stringByAppendingString:@":"];
            SEL selector = NSSelectorFromString(methodString);
            if ([self respondsToSelector:selector])
            {
                [self performSelectorOnMainThread:selector withObject:url.query waitUntilDone:NO];
                decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
                return;
            }
        }
        
    }
    decisionHandler(WKNavigationActionPolicyAllow);//允许跳转


    
//    if ([navigationAction.request.URL.host isEqualToString:@"gameJson"]) {
//        [self gameJson];
//        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
//        return;
//    }
//    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
//    NSURL *url = navigationAction.request.URL;
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && [url.scheme isEqualToString:@"https"]) {
//        [[UIApplication sharedApplication] openURL:url];//手动跳转
//        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
//    }
//    else{
//        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
//    }
    
    
}



#pragma mark  js回调oc方法
// 游戏加载成功回调
- (void)gameLoadSuccess:(NSString *)query {
    NSLog(@"query=======%@",query);
    [self gameLoadSuccess];
    
    if (query) {
        NSDictionary *dic = [self getParameterDicForQuery:query];
        NSLog(@"gameLoadSuccess = %@",dic);

//        NSString *isShow = [[NSString xes_safeString:dic[@"isShow"]] stringByRemovingPercentEncoding];
//        NSString *totalNumber =[[NSString xes_safeString:dic[@"totalNumber"]] stringByRemovingPercentEncoding];
//        [self gameShowProgress:isShow.intValue withTotalNumber:totalNumber.intValue];
    }
    else{
        [self gameShowProgress:0 withTotalNumber:0];
    }
}
//游戏切换题目
- (void)gameLoadProgress:(NSString *)aQuery
{
    NSDictionary *dic = [self getParameterDicForQuery:aQuery];
    NSLog(@"gameLoadProgress = %@",dic);
//    NSString *nowNumber = [[NSString xes_safeString:dic[@"nowNumber"]] stringByRemovingPercentEncoding];
//    NSString *totalNumber =[[NSString xes_safeString:dic[@"totalNumber"]] stringByRemovingPercentEncoding];
//    NSLog(@"nowNumber=%@,totalNumber=%@",nowNumber, totalNumber);
//
//    [self gameLoadQuestionWithNowNumber:nowNumber.intValue totalNumber:totalNumber.intValue];
}
//游戏结束
- (void)gameOver:(NSString *)aQuery {
    NSLog(@"%@",[aQuery stringByRemovingPercentEncoding]);
    
    NSDictionary *dic = [self getParameterDicForQuery:aQuery];
    
    NSString *status = dic[@"status"];
    
    //状态，默认1
    if (!status || [status isKindOfClass:[NSNull class]] ||[status isEqualToString:@""]) {
        status = @"1";
    }
    NSString *totalTime = dic[@"totalTime"];
    //总倒计时，默认0
    if (!totalTime || [totalTime isKindOfClass:[NSNull class]] ||[totalTime isEqualToString:@""]) {
        totalTime = @"0";
    }
    
    
    // 转换格式
    NSError *aError = nil;
    NSData *dataJson = [[dic[@"data"] stringByRemovingPercentEncoding] dataUsingEncoding:NSUTF8StringEncoding];
    //    NSArray *answerInfoArr = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingAllowFragments error:&aError];
    
    if (!dataJson) {
        NSError *error = [NSError errorWithDomain:@"数据格式错误" code:100001 userInfo:nil];
        [self gameLoadFailedWithError:error];
    } else {
        NSArray *answerInfoArr = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingAllowFragments error:&aError];
        
        if (aError) {
            [self gameLoadFailedWithError:aError];
        } else {
            //            [self noticeGameOverWithStatus:status.intValue totalTime:totalTime.intValue result:answerInfoArr];
            [self gameOverWithStatus:status.intValue  totalTime:totalTime.intValue result:answerInfoArr];
        }
    }
    
}
//下载游戏题目失败、解析游戏题目失败
- (void)gameLoadFailed:(NSString *)aQuery
{
    NSDictionary *dic = [self getParameterDicForQuery:aQuery];
    
    NSLog(@"gameLoadFailed = %@",dic);
//    NSString *errCode = [[NSString xes_safeString:dic[@"errcode"]] stringByRemovingPercentEncoding];
//    NSString *errMsg =[[NSString xes_safeString:dic[@"errmsg"]] stringByRemovingPercentEncoding];
//    NSLog(@"errcode=%@,errmsg=%@",errCode, errMsg);
//
//    NSError *aError = [NSError errorWithDomain:errMsg code:errCode.integerValue userInfo:nil];
//
//    [self gameLoadFailedWithError:aError];
}

- (void)gameJson:(NSString *)str {
    
    WKWebView *webView = [self.view viewWithTag:100];
    NSString *jsStr = [NSString stringWithFormat:@"var event = document.createEvent('HTMLEvents');event.initEvent('resignGameJsonBack', true, true);event.data = 'http://ipsgame.speiyou.cn/resources/NumberString.json'; document.dispatchEvent(event);"];
    [webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable idx, NSError * _Nullable error) {
        NSLog(@"error = %@\n",[error localizedDescription]);
        NSLog(@"idx = %@\n",idx);
    }];
    
    
//    WKWebView *webView = [self.view viewWithTag:100];
//    NSString *jsStr = [NSString stringWithFormat:@"var pauseEvent = new Event('resignGameJsonBack(\"abc\")' );document.dispatchEvent(pauseEvent);"];
//    [webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable idx, NSError * _Nullable error) {
//        NSLog(@"error = %@\n",[error localizedDescription]);
//        NSLog(@"idx = %@\n",idx);
//    }];
    
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
    NSLog(@"%s",__func__);
    
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
    
    NSLog(@"%s",__func__);
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
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
    
    NSLog(@"哈哈哈=== %@",webView.URL);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 代理回调到VC
//游戏加载失败
- (void)gameLoadFailedWithError:(NSError *)error {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(xclGameViewGameLoadFailedWithError:)]) {
//        [self.delegate xclGameViewGameLoadFailedWithError:error];
//    }
}
//游戏加载成功
- (void)gameLoadSuccess {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(xclGameViewStart)]) {
//        [self.delegate xclGameViewStart];
//    }
}
//游戏进度显示
- (void)gameLoadQuestionWithNowNumber:(int)nowNumber totalNumber:(int)totalNumber
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(xclGameViewGameLoadQuestionWithNowNumber:totalNumber:)]) {
//        [self.delegate xclGameViewGameLoadQuestionWithNowNumber:nowNumber totalNumber:totalNumber];
//    }
}
//游戏结束：gameOver
- (void)gameOverWithStatus:(int)aStatus  totalTime:(int)aTotalTime result:(id)aReuslt
{
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(xclGameViewGameOverWithStatus:totalTime:result:)]) {
//        [self.delegate xclGameViewGameOverWithStatus:aStatus totalTime:aTotalTime result:aReuslt];
//    }
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(xclGameViewGameOverWithResult:)]) {
    //        [self.delegate xclGameViewGameOverWithResult:aReuslt];
    //    }
    //
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(xclGameViewGameOverWithStatus:result:)]) {
    //        [self.delegate xclGameViewGameOverWithStatus:aStatus result:aReuslt];
    //    }
}

- (void)gameShowProgress:(int)isShow withTotalNumber:(int)totalNumber
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(xclGameViewGameShowProgress:withTotalNumber:)]) {
//        [self.delegate xclGameViewGameShowProgress:isShow withTotalNumber:totalNumber];
//    }
}
#pragma mark 工具方法
- (NSDictionary *)getParameterDicForQuery:(NSString *)aString
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([aString isKindOfClass:[NSString class]])
    {
        NSArray *paraArray = [aString componentsSeparatedByString:@"&"];
        for (NSString *para in paraArray)
        {
            NSArray *paraArray1 = [para componentsSeparatedByString:@"="];
            if (paraArray1.count > 1)
            {
                NSString *key = paraArray1[0];
                NSString *value = paraArray1[1];
                if (key.length > 0 && value.length > 0)
                {
                    [dic setObject:value forKey:key];
                }
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:dic];
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
