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
                                 initWithFrame:CGRectMake(0,0, 300, 250)
                                 placementId:kIMBannerID
                                delegate:self];
        }
        default: {
            self.IMBannerBid = [[IMABMoPubBanner alloc]
                                initWithFrame:CGRectMake(0, 0, 320, 50)
                                placementId:kIMBannerID
                                delegate:self];
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

    
    [self configureBannerForPlacementID:kMPMRECID
                                andSize:MOPUB_MEDIUM_RECT_SIZE];
    
      
    [self.IMBannerBid requestBid:self timeout:kBidTimeout];
    
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
    self.adView.layer.borderWidth = 3;
    self.adView.layer.backgroundColor = [UIColor redColor].CGColor;

    [self.adView stopAutomaticallyRefreshingContents];          
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
         [self createBidForBidType:0];
          [self submitBidFor320x50Banner];
      }
    
}


- (void)adView:(MPAdView *)view didFailToLoadAdWithError:(NSError *)error {
 
    NSLog(@"%@", [kLogTag stringByAppendingString:@"IMAudienceBidder - adViewDidFailToLoadAd"]);
    
    self.bannerKWLoaded = true;

    if (self.isLoadingMrec) {
        // [self submitBidForMRECBanner]; // MREC does not refresh
    }
    else {
        [self createBidForBidType:0];
        [self submitBidFor320x50Banner];
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

- (void)bidRecievedFor:(nullable id)mpAd andInMobiAd:(nonnull id)imAd withTransactionInfo:(nonnull NSString *)keyword {
    
    NSLog(@"IMAudienceBidder - bidRecievedFor withTransactionInfo: %@", keyword);
    
    NSMutableDictionary* extras = [self.adView.localExtras mutableCopy];
    
    if (![extras isKindOfClass:[NSMutableDictionary class]]) {
        extras = [NSMutableDictionary new];
    }
    
    IMFacadeObjectHolder* facadeObject = [[IMFacadeObjectHolder alloc] initWithMoPubObject:self.adView andInMobiObject:imAd];
    
    extras[kIMABInMobiObjectKey] = facadeObject;
    self.adView.localExtras = [NSDictionary dictionaryWithDictionary:extras];
    
    
    NSString* keywords = self.adView.keywords;
    self.adView.keywords = [self processMoPubKeywords:keywords byAppendingInMobiBid:keyword];
    
    if (!self.bannerKWLoaded){
        [self.view addSubview:self.adView];
        [self.adView loadAd];
    }
    
    
}


- (NSString*)processMoPubKeywords:(NSString*)keyword byAppendingInMobiBid:(NSString*)bid {
    if (!keyword) {
        keyword = bid;
    } else {
        keyword = [NSString stringWithFormat:@"%@,%@", keyword, bid];
    }
    return keyword;
}




@end
