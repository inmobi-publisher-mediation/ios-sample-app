//
//  InterstitialKWViewController.h
//  imabmopub
//
//  Created by Jason C on 5/28/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MoPub.h"
#import <InMobiMoPubPlugin/InMobiMoPubPlugin.h>


@interface InterstitialKWViewController : UIViewController <IMABMoPubDelegate, MPInterstitialAdControllerDelegate>


@property (nonatomic, strong) IMABMoPubInterstitial* interstitialKWAd;
@property (strong, nonatomic) MPInterstitialAdController *mpInterstitial;
@property (nonatomic, assign) bool kwInterstitialIsLoaded;

@end


