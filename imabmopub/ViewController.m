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

    NSLog(@"%@", [kLogTag stringByAppendingString:@"DataViewController - viewDidLoad"]);
    
    [self setupAdditionalViewElements];
    [self initializeSDKs];
    [super viewDidLoad];
    
}

// Extra fluff: Gets the SDK versions and sets labels.
- (void)setupAdditionalViewElements{
    
    // Set title and text information for SDK versions
    self.title = kAppName;
    
    self.InMobiSDKVersion.text = [NSString stringWithFormat:@"%s%@", "InMobi SDK Version: ", [AerServSDK sdkVersion]];;
    self.MoPubSDKVersion.text = [NSString stringWithFormat:@"%s%@", "MoPub SDK Version: ", MP_SDK_VERSION];
    
}

// Handle any initialization here.
-(void)initializeSDKs {
    
//    [IMAudienceBidder initializeWithAppID:kIMABAppID andUserConsent:@{ IM_GDPR_CONSENT_AVAILABLE : @YES }];
    
}





@end
