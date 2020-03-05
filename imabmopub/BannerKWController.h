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


@interface BannerKWController : UIViewController <MPAdViewDelegate, IMAudienceBidderDelegate>

@property (strong, nonatomic) MPAdView *adView;                                     // For MoPub Banner

@end
