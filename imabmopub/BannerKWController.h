//
//  BannerKWController.h
//  imabmopub
//
//  Created by Jason C on 2/11/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoPub.h"
#import <InMobiSDK/InMobiSDK.h>
#import <InMobiMoPubPlugin/InMobiMoPubPlugin.h>

@interface BannerKWController : UIViewController <MPAdViewDelegate, IMABMoPubDelegate>

@property (nonatomic, strong) MPAdView *adView;
@property (nonatomic, strong) IMABMoPubBanner *IMBannerBid;

@property (nonatomic, assign) Boolean bannerKWLoaded;
@property (nonatomic, assign) Boolean isLoadingMrec;


@end
