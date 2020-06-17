//
//  MaxTestBannerController.h
//  imabmax
//
//  Created by Jason C on 4/7/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppLovinSDK/AppLovinSDK.h>


NS_ASSUME_NONNULL_BEGIN

@interface MaxTestBannerController : UIViewController <MAAdViewAdDelegate>

@property (nonatomic, strong) MAAdView *adView;
@property (nonatomic, strong) MAAdView *mrecView;



@end

NS_ASSUME_NONNULL_END
