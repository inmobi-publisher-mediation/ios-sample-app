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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadBannerAd];
    [self loadMrecAd];
    [self loadInterstitialAd];
}

- (void)loadBannerAd {
    self.asBannerAdView = [ASAdView viewWithPlacementID:@"1069149" andAdSize:ASBannerSize];
    self.asBannerAdView.delegate = self;
    [self.asBannerAdView setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 320)/2, ([[UIScreen mainScreen] bounds].size.height - 50), 320, 50)];
    [self.view addSubview:self.asBannerAdView];
    [self.asBannerAdView loadAd];
}

- (void)loadMrecAd {
    self.asMRECAdView = [ASAdView viewWithPlacementID:@"1069150" andAdSize:ASMediumRectSize];
    self.asMRECAdView.delegate = self;
    [self.asMRECAdView setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 300)/2, ([[UIScreen mainScreen] bounds].size.height - 350), 300, 250)];

    [self.view addSubview:self.asMRECAdView];
    [self.asMRECAdView loadAd];

}

- (void)loadInterstitialAd {
    self.asInterstitialVC = [ASInterstitialViewController viewControllerForPlacementID:@"1069151" withDelegate:self];
    [self.asInterstitialVC loadAd];
}


#pragma mark - AerServ Interstitial Callbacks
- (void)interstitialViewControllerAdLoadedSuccessfully:(ASInterstitialViewController*)viewController {
  [self.asInterstitialVC showFromViewController:self];
}

@end
