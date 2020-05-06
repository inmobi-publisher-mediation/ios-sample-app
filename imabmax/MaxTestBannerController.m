//
//  MaxTestBannerController.m
//  imabmax
//
//  Created by Jason C on 4/7/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "MaxTestBannerController.h"

@interface MaxTestBannerController ()

@end

@implementation MaxTestBannerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBannerAd];
    [self createMrecAd];
}



- (void)createBannerAd {
    self.adView = [[MAAdView alloc] initWithAdUnitIdentifier: @"9a1dc9f805b06bca"];
    self.adView.delegate = self;

    // Banner height on iPhone and iPad is 50 and 90, respectively
    CGFloat height = (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) ? 90 : 50;

    // Stretch to the width of the screen for banners to be fully functional
    CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds);

    self.adView.frame = CGRectMake(0, ([[UIScreen mainScreen] bounds].size.height - (height*2)), width, height);

    // Set background or background color for banners to be fully functional
    self.adView.backgroundColor = UIColor.blackColor;

    [self.view addSubview: self.adView];

    // Load the first ad
    [self.adView loadAd];
    

}



- (void)createMrecAd {
    self.mrecView = [[MAAdView alloc] initWithAdUnitIdentifier: @"8112cbac910b7de2" adFormat: MAAdFormat.mrec];

//    self.adView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mrecView.delegate = self;

    // MREC width and height are 300 and 250, respectively on iPhone and iPad
    CGFloat width = 300;
    CGFloat height = 250;

    // Center the MREC
    CGFloat x = self.view.center.x - 150;

    self.mrecView.frame = CGRectMake(x, ([[UIScreen mainScreen] bounds].size.height - (height*2)), width, height);

    // Set background or background color for banners to be fully functional
    self.mrecView.backgroundColor = UIColor.redColor;

    [self.view addSubview: self.mrecView];

    // Load the first ad
    [self.mrecView loadAd];
    

}





#pragma mark - MAAdDelegate Protocol

- (void)didLoadAd:(MAAd *)ad {
    
    if (ad.format == MAAdFormat.mrec) {
        self.mrecView.hidden = NO;
        [self.mrecView startAutoRefresh];

    } else  {
        if (self.adView != NULL) {
            self.adView.hidden = NO;
            [self.adView startAutoRefresh];
        }

    }

}

- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withErrorCode:(NSInteger)errorCode {}

- (void)didDisplayAd:(MAAd *)ad {}

- (void)didHideAd:(MAAd *)ad {}

- (void)didClickAd:(MAAd *)ad {}

- (void)didFailToDisplayAd:(MAAd *)ad withErrorCode:(NSInteger)errorCode {}

#pragma mark - MAAdViewAdDelegate Protocol

- (void)didExpandAd:(MAAd *)ad {}

- (void)didCollapseAd:(MAAd *)ad {}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
