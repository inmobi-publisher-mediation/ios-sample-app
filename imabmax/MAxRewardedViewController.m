//
//  MAxRewardedViewController.m
//  imabmax
//
//  Created by Jason C on 4/7/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "MAxRewardedViewController.h"

@interface MAxRewardedViewController ()

@end

@implementation MAxRewardedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)touchLoadRewarded:(id)sender {
    [self createRewardedAd];
}


- (IBAction)touchShowRewarded:(id)sender {
    if ( [self.rewardedAd isReady] ){
        [self.rewardedAd showAd];
    }
}


- (void)createRewardedAd{
    self.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier: @"d4f2e8a152818109"];
    self.rewardedAd.delegate = self;
    [self.rewardedAd loadAd];
}

#pragma mark - MAAdDelegate Protocol

- (void)didLoadAd:(MAAd *)ad{

    // Reset retry attempt
    self.retryAttempt = 0;
}

- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withErrorCode:(NSInteger)errorCode
{
    self.retryAttempt++;
    NSInteger delaySec = pow(2, self.retryAttempt);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.rewardedAd loadAd];
    });
}

- (void)didDisplayAd:(MAAd *)ad {}

- (void)didClickAd:(MAAd *)ad {}

- (void)didHideAd:(MAAd *)ad{
    // Rewarded ad is hidden. Pre-load the next ad
    [self.rewardedAd loadAd];
}

- (void)didFailToDisplayAd:(MAAd *)ad withErrorCode:(NSInteger)errorCode{
    // Rewarded ad failed to display. We recommend loading the next ad
    [self.rewardedAd loadAd];
}

#pragma mark - MARewardedAdDelegate Protocol

- (void)didStartRewardedVideoForAd:(MAAd *)ad {}

- (void)didCompleteRewardedVideoForAd:(MAAd *)ad {}

- (void)didRewardUserForAd:(MAAd *)ad withReward:(MAReward *)reward{
    // Rewarded ad was displayed and user should receive the reward
    
}



@end
