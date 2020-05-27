===================================
InMobi MoPub Plugin for iOS
===================================

Build 9.0.7.0 [24/Apr/2020]
-------------
- Added Audience Bidding Support.
- New classes added:
   IMABMoPubBanner:
        - (instancetype)initWithFrame:(CGRect)frame placementId:(long long)placementId delegate:(id<IMABMoPubDelegate>)delegate;
        - (void)requestBid:(NSTimeInterval)timeout;
        - (void)requestBid:(nullable id)ad timeout:(NSTimeInterval)timeout;
    IMABMoPubInterstitial:
        - (instancetype)initWithPlacementId:(long long)placementId delegate:(id<IMABMoPubDelegate>)delegate;
        - (void)requestBid:(NSTimeInterval)timeout;
        - (void)requestBid:(nullable id)ad timeout:(NSTimeInterval)timeout;
    IMABMoPubDelegate:
        - (void)bidRecievedFor:(nullable id)mpAd andInMobiAd:(id)imAd withTransactionInfo:(NSString*)keyword;
        - (void)bidFailedFor:(nullable id)ad withError:(NSError*)error;
    IMFacadeObjectHolder:
        - (instancetype)initWithMoPubObject:(nullable id)mpAd andInMobiObject:(id)imAd;
        
    
