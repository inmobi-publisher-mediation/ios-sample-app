//
//  MaxTestViewController.m
//  imabmax
//
//  Created by Jason C on 3/26/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "MaxTestViewController.h"
#import <AppLovinSDK/AppLovinSDK.h>


@interface MaxTestViewController () <MAAdDelegate>
@property (nonatomic, strong) MAInterstitialAd *interstitialAd;
@property (nonatomic, assign) NSInteger retryAttempt;
@end

@implementation MaxTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)loadInterstitial:(id)sender {
    [self createInterstitialAd];
}


- (IBAction)showInterstitial:(id)sender {
    if ([self.interstitialAd isReady]) {
        [self.interstitialAd showAd];
    }
}


- (void)createInterstitialAd
{
    self.interstitialAd = [[MAInterstitialAd alloc] initWithAdUnitIdentifier: @"93e7b5a438c9a4e7"];
    self.interstitialAd.delegate = self;

    // Load the first ad
    [self.interstitialAd loadAd];
}



#pragma mrk - MAAdDelegate Protocol methods

- (void)didLoadAd:(MAAd *)ad
{
    // Interstitial ad is ready to be shown. '[self.interstitialAd isReady]' will now return 'YES'

    // Reset retry attempt
    self.retryAttempt = 0;
}

- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withErrorCode:(NSInteger)errorCode
{
    // Interstitial ad failed to load. We recommend retrying with exponentially higher delays.
    
    self.retryAttempt++;
    NSInteger delaySec = pow(2, self.retryAttempt);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.interstitialAd loadAd];
    });
}

- (void)didDisplayAd:(MAAd *)ad {}

- (void)didClickAd:(MAAd *)ad {}

- (void)didHideAd:(MAAd *)ad
{
    // Interstitial ad is hidden. Pre-load the next ad
    [self.interstitialAd loadAd];
}

- (void)didFailToDisplayAd:(MAAd *)ad withErrorCode:(NSInteger)errorCode
{
    // Interstitial ad failed to display. We recommend loading the next ad
    [self.interstitialAd loadAd];
}


@end
