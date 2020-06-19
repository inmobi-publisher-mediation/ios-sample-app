//
//  BannerKWController.m
//  imabmopub
//
//  Created by Jason C on 2/11/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "BannerKWController.h"
#import "Constants.h"


@implementation BannerKWController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adView = nil;
    self.IMBannerBid = nil;
    self.bannerKWLoaded = false;
    self.isLoadingMrec = false;
}



#pragma mark - <IBAction Methods>



- (IBAction)makeBannerBid:(id)sender {
    self.bannerKWLoaded = false;
    [self createBidForBidType:0];
    [self submitBidFor320x50Banner];
}


- (IBAction)makeMrecBid:(id)sender {
    self.bannerKWLoaded = false;
    [self createBidForBidType:1];
    [self submitBidForMRECBanner];
}



#pragma mark - <IMAB Banner Methods>


- (void) createBidForBidType:(NSInteger)type {
    
    switch (type) {
        case 1: {
            self.IMBannerBid = [[IMABMoPubBanner alloc]
                                initWithSize: CGSizeMake(300, 250)
                                placementId: kIMMRECID
                                delegate: self];
            break;
        }
        default: {
            self.IMBannerBid = [[IMABMoPubBanner alloc]
                                initWithSize: CGSizeMake(330, 50)
                                placementId: kIMBannerID
                                delegate: self];
        }

    }
}


- (void) submitBidFor320x50Banner {
    
    if (!self.IMBannerBid){
        // createBidForBidType has not yet been called, short-terminate.
        return;
    }
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - submitBannerKWBid"]);
    self.isLoadingMrec = false;
    
    [self configureBannerForPlacementID:kMPBannerID
                                andSize:MOPUB_BANNER_SIZE];
    [self.IMBannerBid requestBid:self timeout:kBidTimeout];
}


- (void) submitBidForMRECBanner {
    
    if (!self.IMBannerBid){
        // createBidForBidType has not yet been called, short-terminate.
        return;
    }
    
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - submitMRECKWBid"]);
    self.isLoadingMrec = true;
    [self.IMBannerBid requestBid:self timeout:kBidTimeout];
    [self configureBannerForPlacementID:kMPMRECID
                                andSize:MOPUB_MEDIUM_RECT_SIZE];
    
}


- (void) cleanupBanner {
    self.isLoadingMrec = false;
    self.bannerKWLoaded = false;
    // TODO: Additional cleanup here
}


- (void) configureBannerForPlacementID:(NSString*)mopubPLC andSize:(CGSize)size {
    
    self.adView = [[MPAdView alloc] initWithAdUnitId:mopubPLC];
    self.adView.frame = CGRectMake((self.view.bounds.size.width - size.width) / 2, self.view.bounds.size.height - (size.height), size.width, size.height);
    
    self.adView.layer.borderColor = [UIColor blackColor].CGColor;
    self.adView.layer.borderWidth = 1;
    self.adView.layer.backgroundColor = [UIColor redColor].CGColor;

    [self.adView startAutomaticallyRefreshingContents];
    
    self.adView.delegate = self;
}



#pragma mark - <MPAdViewDelegate>



- (void)adViewDidLoadAd:(MPAdView *)view adSize:(CGSize)adSize {
    
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - adViewDidLoadAd"]);

    self.bannerKWLoaded = true;
        
     if (self.isLoadingMrec) {
          // [self submitBidForMRECBanner]; // MREC does not refresh
      }
     else {
      [self.IMBannerBid requestBid:self timeout:kBidTimeout];
      }
    
}


- (void)adView:(MPAdView *)view didFailToLoadAdWithError:(NSError *)error {
 
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - adViewDidFailToLoadAd"]);
    
    self.bannerKWLoaded = true;

    if (self.isLoadingMrec) {
        // [self submitBidForMRECBanner]; // MREC does not refresh
    }
    else {
        [self.IMBannerBid requestBid:self timeout:kBidTimeout];
    }
    
}



#pragma mark - IMAB V2 Banner delegates



- (void)bidFailedFor:(nullable id)ad withError:(nonnull NSError *)error {
    
    NSLog(@"IMAudienceBidder:- bidFailedFor withError: %@", error.localizedDescription);
    
    if (!self.bannerKWLoaded){
        [self.view addSubview:self.adView];
        [self.adView loadAd];
    }
    
}



- (void)bidReceivedFor:(id)mpAd andInMobiAd:(id)imAd withTransactionInfo:(NSString *)keyword {
    
    NSLog(@"IMAudienceBidder - bidRecievedFor withTransactionInfo: %@", keyword);
    
    // Create a facade wrapper, provide mopub ad view / banner view
    
    
    IMFacadeWrapper* facadeWrapper = [[IMFacadeWrapper alloc] initWithMoPubObject:self.adView andInMobiObject:imAd];
    self.adView.localExtras = @{kIMABInMobiObjectKey : facadeWrapper};
    

    [self.adView setKeywords:keyword];
    
    if (!self.bannerKWLoaded){
        [self.view addSubview:self.adView];
        [self.adView loadAd];
    }
    
    
}



@end
