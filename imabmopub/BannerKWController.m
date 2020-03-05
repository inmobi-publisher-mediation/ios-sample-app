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



#pragma mark - <IBAction Methods>



- (IBAction)makeMrecBid:(id)sender {
    bannerKWLoaded = false;
    [self submitBidForMRECBanner];
}

- (IBAction)injectBanner:(id)sender {
    bannerKWLoaded = false;
    [self injectBannerIntoView];
}



#pragma mark - <IMAB Delegate Methods>



- (void)audienceBidderDidFailBidFor:(id)adObject withError:(NSError *)error {
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - audienceBidderDidFailBidFor"]);
    
    if([adObject isKindOfClass:[MPAdView class]]) {
        
        if (!bannerKWLoaded){
            [self.adView loadAd];
        }
        
    }
    
}

- (void)audienceBidderDidGenerateBidResponse:(IMBidResponse *)bidResponse {
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - audienceBidderDidGenerateBidResponse"]);
    
    [self.adView setKeywords:bidResponse.keyword];
    self.adView.localExtras = @{kIMABLocalCacheKey : bidResponse.placement};
        
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
    
    self.adView = [[MPAdView alloc] initWithAdUnitId:mopubPLC];
    self.adView.frame = CGRectMake((self.view.bounds.size.width - size.width) / 2, self.view.bounds.size.height - (size.height), size.width, size.height);
    

    self.adView.layer.borderColor = [UIColor blackColor].CGColor;
    self.adView.layer.borderWidth = 3;
    self.adView.layer.backgroundColor = [UIColor redColor].CGColor;

    [self.adView stopAutomaticallyRefreshingContents];          
    self.adView.delegate = self;

}



#pragma mark - <MPAdViewDelegate>



- (void)adViewDidLoadAd:(MPAdView *)view {
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - adViewDidLoadAd"]);

    bannerKWLoaded = true;
        
     if (isLoadingMrec) {
          [self submitBidForMRECBanner];
      }
     else {
          [self submitBidFor320x50Banner];
      }
    
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view {
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - adViewDidFailToLoadAd"]);
    
    bannerKWLoaded = true;

    if (isLoadingMrec) {
        [self submitBidForMRECBanner];
    }
    else {
        [self submitBidFor320x50Banner];
    }
}



@end
