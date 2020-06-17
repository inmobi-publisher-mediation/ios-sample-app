//
//  ViewController.m
//  clientSDKMediation
//
//  Created by Jason C on 3/20/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "MediationVC.h"


@interface MediationVC () <ASAdViewDelegate, ASInterstitialViewControllerDelegate>

@end

@implementation MediationVC

NSString *default_test_interstitial_id = @"1069151";
NSString *default_test_320x50_id = @"1069149";
NSString *default_test_mrec_id = @"1069150";

NSString *admob_test_320x50 = @"1069144";
NSString *admob_test_mrec = @"1069145";
NSString *admob_test_int = @"1069146";

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (NSString *) util_getPlacementFromInput{
    NSLog(@"util found:%@", [self.TextInput text]);
    return [self.TextInput text];
}

# pragma mark - IB Actions

- (IBAction)pressLoadBanner:(id)sender {
    [self loadBannerAdForPlacement:[self util_getPlacementFromInput]];
    [self.view endEditing:YES];

}


- (IBAction)pressLoadMrec:(id)sender {
    [self loadMrecAdForPlacement:[self util_getPlacementFromInput]];
    [self.view endEditing:YES];

}

- (IBAction)pressLoadInterstitial:(id)sender {
    [self loadInterstitialAdForPlacement:[self util_getPlacementFromInput]];
    [self.view endEditing:YES];

}

# pragma mark - Ad Methods

- (void)loadBannerAdForPlacement:(NSString*)plc {
    self.asBannerAdView = [ASAdView viewWithPlacementID:plc andAdSize:ASBannerSize];
    self.asBannerAdView.delegate = self;
    [self.asBannerAdView setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 320)/2, ([[UIScreen mainScreen] bounds].size.height - 50), 320, 50)];
    [self.view addSubview:self.asBannerAdView];
    [self.asBannerAdView loadAd];
}

- (void)loadMrecAdForPlacement:(NSString*)plc {
    self.asMRECAdView = [ASAdView viewWithPlacementID:plc andAdSize:ASMediumRectSize];
    self.asMRECAdView.delegate = self;
    [self.asMRECAdView setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 300)/2, ([[UIScreen mainScreen] bounds].size.height - 350), 300, 250)];

    [self.view addSubview:self.asMRECAdView];
    [self.asMRECAdView loadAd];

}

- (void)loadInterstitialAdForPlacement:(NSString*)plc {
    self.asInterstitialVC = [ASInterstitialViewController viewControllerForPlacementID:plc withDelegate:self];
    [self.asInterstitialVC loadAd];
}


#pragma mark - AerServ Interstitial Callbacks
- (void)interstitialViewControllerAdLoadedSuccessfully:(ASInterstitialViewController*)viewController {
  [self.asInterstitialVC showFromViewController:self];
}

- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

@end
