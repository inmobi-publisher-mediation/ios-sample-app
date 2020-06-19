//
//  InterstitialKWViewController.m
//  imabmopub
//
//  Created by Jason C on 5/28/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "InterstitialKWViewController.h"

@interface InterstitialKWViewController ()

@end

@implementation InterstitialKWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doInterstitialKWBid:(id)sender {
    [self requestBidForInterstitial];
}


#pragma mark - Interstital KW bid

- (void)requestBidForInterstitial {

    self.mpInterstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:kMPInterstitialID];
    self.mpInterstitial.delegate = self;
    

    self.interstitialKWAd = [[IMABMoPubInterstitial alloc]initWithPlacementId:kIMInterstitialID delegate:self];
    
    // If you wish to manage your own keywords, don't pass the mopub view
    [self.interstitialKWAd requestBid:kBidTimeout];
    

}


#pragma mark - IMAB V2 Interstitial delegates


- (void)bidFailedFor:(nullable id)ad withError:(nonnull NSError *)error {
    NSLog(@"IMAudienceBidder:- bidFailedFor withError: %@", error.localizedDescription);
    
    // Load your interstitial as normal - InMobi doesn't have a bid
    
}

- (void)bidReceivedFor:(id)mpAd andInMobiAd:(id)imAd withTransactionInfo:(NSString *)keyword {
        
    NSLog(@"IMAudienceBidder - bidRecievedFor withTransactionInfo: %@", keyword);
    
    NSMutableDictionary* extras = [self.mpInterstitial.localExtras mutableCopy];
      if (![extras isKindOfClass:[NSMutableDictionary class]]) {
          extras = [NSMutableDictionary new];
      }
    
    
    IMFacadeWrapper* facadeWrapper = [[IMFacadeWrapper alloc] initWithMoPubObject:self.mpInterstitial andInMobiObject:self.interstitialKWAd];
    self.mpInterstitial.localExtras=@{kIMABInMobiObjectKey: facadeWrapper};
    [self.mpInterstitial setKeywords:keyword];
    

    // Once all of your remaining header bidders have returned, you can call loadAd.
    [self.mpInterstitial loadAd];
}


// Helper method (most publishers will write their own)

- (NSString*)processMoPubKeywords:(NSString*)keyword byAppendingInMobiBid:(NSString*)bid {
    if (!keyword) {
        keyword = bid;
    } else {
        keyword = [NSString stringWithFormat:@"%@,%@", keyword, bid];
    }
    return keyword;
}



#pragma mark - MoPub Delegates


- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
 
    // Fetch a new bid here if desired.
    [self requestBidForInterstitial];
    
}

- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    
    // DO NOT MAKE a new bid now. Bad idea.
    if (self.mpInterstitial.ready)
        [self.mpInterstitial showFromViewController:self];

}


- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial{
    
    // DO NOT MAKE a new bid now. Bad idea.
    // Instead, wait and then request a bid. Wait X seconds.
    
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial
                          withError:(NSError *)error {
    
    // DO NOT MAKE a new bid now. Bad idea.
    // Instead, wait and then request a bid. Wait X seconds.
    
}


- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial {}
- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial {}
- (void)interstitialWillDisappear:(MPInterstitialAdController *)interstitial {}
- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial {}
- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial{}


@end
