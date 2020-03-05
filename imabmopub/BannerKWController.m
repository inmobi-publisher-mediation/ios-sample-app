//
//  BannerKWController.m
//  imabmopub
//
//  Created by Jason C on 2/11/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "BannerKWController.h"
#import "Constants.h"

@interface BannerKWController ()

@end

@implementation BannerKWController

Boolean bannerKWLoaded = false;
Boolean isLoadingMrec = false;


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)makeMrecBid:(id)sender {
    bannerKWLoaded = false;
    [self submitBidForMRECBanner];
}
- (IBAction)injectBanner:(id)sender {
    bannerKWLoaded = false;
    [self injectBannerIntoView];
}

#pragma mark - <IMAB Delegate Methods>

// When a bid is made with createBid and then submitted, this delegate is called if we do not get a bid
- (void)audienceBidderDidFailBidFor:(id)adObject withError:(NSError *)error {
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - audienceBidderDidFailBidFor"]);
    
    // If the returned and updated adObject is a banner:
    if([adObject isKindOfClass:[MPAdView class]]) {
        
        // If the banner has not yet been loaded, call loadAd on the updated ad view
        if (!bannerKWLoaded){
            [self.adView loadAd];
        }
        
    }
    
    
    
}


// This delegate should be invoked if we are not using bid objects and used submitBidForAdType
- (void)audienceBidderDidGenerateBidResponse:(IMBidResponse *)bidResponse {
        
    // Set or append the returned InMobi bidResponse keywords on the adView
    [self.adView setKeywords:bidResponse.keyword];
        
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - audienceBidderDidGenerateBidResponse"]);
        
    // Set the local extras of the adview
    self.adView.localExtras = @{kIMABLocalCacheKey : bidResponse.placement};
        
        // If the banner has not yet been loaded, call loadAd on the updated MPAdView
        if (!bannerKWLoaded){
            [self.adView loadAd];
        }
    
}



#pragma mark - <IMAB Banner Methods>

- (void) injectBannerIntoView {
    [self.view addSubview:self.adView];
}



- (void) submitBidFor320x50Banner {
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - submitBannerKWBid"]);
    isLoadingMrec = false;
    
    if (!bannerKWLoaded){
        [self configureBannerForPlacementID:kMPBannerID andSize:MOPUB_BANNER_SIZE];
    }
    [IMAudienceBidder submitBidForAdType:kIMBiddingAdTypeBanner withPlacement:kASBannerID adSize:MOPUB_BANNER_SIZE andDelegate:self];
}

- (void) submitBidForMRECBanner {
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - submitMRECKWBid"]);
    isLoadingMrec = true;

    
    if (!bannerKWLoaded){
        [self configureBannerForPlacementID:kMPMRECID andSize:MOPUB_MEDIUM_RECT_SIZE];
    }
    [IMAudienceBidder submitBidForAdType:kIMBiddingAdTypeBanner withPlacement:kASMRECID adSize:MOPUB_MEDIUM_RECT_SIZE andDelegate:self];
}

- (void) cleanupBanner {
    isLoadingMrec = false;
    bannerKWLoaded = false;
    // TODO: cleanup view
}


- (void) configureBannerForPlacementID:(NSString*)mopubPLC andSize:(CGSize)size {
    
//    self.adView = [[MPAdView alloc] initWithAdUnitId:plc size:size];
    self.adView = [[MPAdView alloc] initWithAdUnitId:mopubPLC];
    
    self.adView.frame = CGRectMake((self.view.bounds.size.width - size.width) / 2, self.view.bounds.size.height - (size.height), size.width, size.height);
    
    // Optional: Add a border and background color so we know the adView has been added
    self.adView.layer.borderColor = [UIColor blackColor].CGColor;
    self.adView.layer.borderWidth = 3;
    self.adView.layer.backgroundColor = [UIColor redColor].CGColor;

    [self.adView stopAutomaticallyRefreshingContents];              // Ensure MoPub banner refresh is disabled. Consult your account manager if you have any questions.
    self.adView.delegate = self;
//    [self.view addSubview:self.adView];
//    [self.adView loadAd];
}



#pragma mark - <MPAdViewDelegate - for Banners!>

- (void)adViewDidLoadAd:(MPAdView *)view {
    
    // Ensure that we do not call loadAd again on the MPAdView
    bannerKWLoaded = true;
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - adViewDidLoadAd"]);

    
     if (isLoadingMrec) {
          [self submitBidForMRECBanner];
      } else {
          [self submitBidFor320x50Banner];
      }
    
}


- (void)adViewDidFailToLoadAd:(MPAdView *)view {
    
    // Ensure that we do not call loadAd again on the MPAdView
    bannerKWLoaded = true;
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - adViewDidFailToLoadAd"]);

    if (isLoadingMrec) {
        [self submitBidForMRECBanner];
    } else {
        [self submitBidFor320x50Banner];
        
    }
}






@end
