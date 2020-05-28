//
//  InterstitialViewController.h
//  imabmopub
//
//  Created by Jason C on 5/28/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MoPub.h"
#import <InMobiMoPubPlugin/InMobiMoPubPlugin.h>


@interface InterstitialViewController : UIViewController <IMABMoPubDelegate, MPInterstitialAdControllerDelegate>

@property (nonatomic, strong) IMABMoPubInterstitial* interstitialAd;
@property (strong, nonatomic) MPInterstitialAdController *mpInterstitial;
@property (nonatomic, assign) BOOL interstitialIsLoaded;

@end


