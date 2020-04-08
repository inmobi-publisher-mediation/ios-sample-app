//
//  ViewController.m
//  clientSDKMediation
//
//  Created by Jason C on 3/20/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "ViewController.h"
#import <InMobiSDK/InMobiSDK.h>


@interface ViewController () <ASAdViewDelegate, ASInterstitialViewControllerDelegate>

@property(nonatomic, strong) ASAdView* asBannerAdView;
@property(nonatomic, strong) ASAdView* asMRECAdView;
@property(nonatomic, strong) ASInterstitialViewController* asInterstitialVC;


@end

@implementation ViewController

NSString *default_test_interstitial_id = @"1069151";
NSString *default_test_320x50_id = @"1069149";
NSString *default_test_mrec_id = @"1069150";

NSString *admob_test_320x50 = @"1069144";
NSString *admob_test_mrec = @"1069145";
NSString *admob_test_int = @"1069146";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBannerAd];
    [self loadMrecAd];
    [self loadInterstitialAd];
}

- (void)loadBannerAd {
    self.asBannerAdView = [ASAdView viewWithPlacementID:admob_test_320x50 andAdSize:ASBannerSize];
    self.asBannerAdView.delegate = self;
    [self.asBannerAdView setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 320)/2, ([[UIScreen mainScreen] bounds].size.height - 50), 320, 50)];
    [self.view addSubview:self.asBannerAdView];
    [self.asBannerAdView loadAd];
}

- (void)loadMrecAd {
    self.asMRECAdView = [ASAdView viewWithPlacementID:admob_test_mrec andAdSize:ASMediumRectSize];
    self.asMRECAdView.delegate = self;
    [self.asMRECAdView setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 300)/2, ([[UIScreen mainScreen] bounds].size.height - 350), 300, 250)];

    [self.view addSubview:self.asMRECAdView];
    [self.asMRECAdView loadAd];

}

- (void)loadInterstitialAd {
    self.asInterstitialVC = [ASInterstitialViewController viewControllerForPlacementID:admob_test_int withDelegate:self];
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
