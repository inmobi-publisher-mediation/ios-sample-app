//
//  ViewController.m
//  imabmopub
//
//  Created by Jason C on 2/11/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - <View / IB Actions / Init methods>

- (void)viewDidLoad {
    
    [self setupAdditionalViewElements];
    [super viewDidLoad];
    
}


- (void)setupAdditionalViewElements{
    
    self.title = kAppName;
    self.InMobiSDKVersion.text = [NSString stringWithFormat:@"%s%@", "InMobi SDK Version: ", [AerServSDK sdkVersion]];;
    self.MoPubSDKVersion.text = [NSString stringWithFormat:@"%s%@", "MoPub SDK Version: ", MP_SDK_VERSION];

}


@end

