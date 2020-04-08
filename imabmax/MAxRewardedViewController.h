//
//  MAxRewardedViewController.h
//  imabmax
//
//  Created by Jason C on 4/7/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppLovinSDK/AppLovinSDK.h>


NS_ASSUME_NONNULL_BEGIN

@interface MAxRewardedViewController : UIViewController <MARewardedAdDelegate>

@property (nonatomic, strong) MARewardedAd *rewardedAd;
@property (nonatomic, assign) NSInteger retryAttempt;

@end

NS_ASSUME_NONNULL_END
