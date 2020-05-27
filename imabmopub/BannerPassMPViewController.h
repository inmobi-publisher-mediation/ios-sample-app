//
//  BannerPassMPViewController.h
//  imabmopub
//
//  Created by Jason C on 5/27/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoPub.h"
#import <InMobiMoPubPlugin/InMobiMoPubPlugin.h>

@interface BannerPassMPViewController : UIViewController <MPAdViewDelegate, IMABMoPubDelegate>

@property (nonatomic, strong) MPAdView *adView;
@property (nonatomic, strong) IMABMoPubBanner *IMBannerBid;

@property (nonatomic, assign) Boolean bannerLoaded;
@property (nonatomic, assign) Boolean isLoadingMrec;



@end

