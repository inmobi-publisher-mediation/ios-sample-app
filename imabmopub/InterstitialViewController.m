//
//  InterstitialViewController.m
//  imabmopub
//
//  Created by Jason C on 5/28/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "InterstitialViewController.h"

@interface InterstitialViewController ()

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark - IB Actions

- (IBAction)doInterstitalBid:(id)sender {
    [self requestBidForInterstitial];
}


#pragma mark - Interstital bid

- (void)requestBidForInterstitial {

    self.mpInterstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:kMPInterstitialID];
    self.mpInterstitial.delegate = self;
    

    self.interstitialAd = [[IMABMoPubInterstitial alloc]initWithPlacementId:kIMInterstitialID delegate:self];
//    [self.interstitialAd requestBid:kBidTimeout];
    [self.interstitialAd requestBid:self.mpInterstitial timeout:kBidTimeout];

}


#pragma mark - IMAB V2 Interstitial delegates


- (void)bidFailedFor:(nullable id)ad withError:(nonnull NSError *)error {
    NSLog(@"IMAudienceBidder:- bidFailedFor withError: %@", error.localizedDescription);
    
    // Load your interstitial as normal - InMobi doesn't have a bid
    
}

- (void)bidReceivedFor:(id)mpAd andInMobiAd:(id)imAd withTransactionInfo:(NSString *)keyword{
        
    NSLog(@"IMAudienceBidder - bidRecievedFor withTransactionInfo: %@", keyword);
    
    // We've updated the MoPub interstital for you.
    // Once all of your remaining header bidders have returned, you can call loadAd.
    
    [self.mpInterstitial loadAd];
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
