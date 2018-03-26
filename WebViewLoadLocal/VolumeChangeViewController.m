//
//  VolumeChangeViewController.m
//  WebViewLoadLocal
//
//  Created by gfy on 2018/3/22.
//  Copyright © 2018年 gfy. All rights reserved.
//

#import "VolumeChangeViewController.h"

#import <AVFoundation/AVFoundation.h>

#import <MediaPlayer/MediaPlayer.h>

#import <SystemConfiguration/CaptiveNetwork.h>

@interface VolumeChangeViewController ()

@end

@implementation VolumeChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)volumeChangeZero:(id)sender {
    
    
//    MPMusicPlayerController *mpc = [MPMusicPlayerController applicationMusicPlayer];
//    mpc.volume = 0;  //0.0~1.0
//
//    return;
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    volumeView.showsVolumeSlider = NO;
    UISlider *volumeViewSlider = nil;
    
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    float systemVolume = volumeViewSlider.value;
    NSLog(@"当前音量===%f",systemVolume);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [volumeViewSlider setValue:0.0f animated:NO];
    });
    // change system volume, the value is between 0.0f and 1.0f
    // send UI control event to make the change effect right now.
    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    [volumeView sizeToFit];
}
- (IBAction)volumeChangeOne:(id)sender {
    
    id info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSString *str = info[@"SSID"];
        NSString *str2 = info[@"BSSID"];
        NSString *str3 = [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
        NSLog(@"str = %@",str);
        NSLog(@"str2 = %@",str2);
        NSLog(@"str3 = %@",str3);
        
        NSLog(@"\n");
    }
    
    
    return;
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    volumeView.showsVolumeSlider = YES;
    UISlider *volumeViewSlider = nil;
    
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    float systemVolume = volumeViewSlider.value;
    
    // change system volume, the value is between 0.0f and 1.0f
    [volumeViewSlider setValue:1.0f animated:NO];
//    [[MPMusicPlayerController applicationMusicPlayer] setVolume: 1.0];
    // send UI control event to make the change effect right now.
    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
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
