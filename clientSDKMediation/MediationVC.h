//
//  ViewController.h
//  clientSDKMediation
//
//  Created by Jason C on 3/20/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <InMobiSDK/InMobiSDK.h>


@interface MediationVC : UIViewController

@property(nonatomic, strong) ASAdView* asBannerAdView;
@property(nonatomic, strong) ASAdView* asMRECAdView;
@property(nonatomic, strong) ASInterstitialViewController* asInterstitialVC;

@property (weak, nonatomic) IBOutlet UITextField *TextInput;

@end

//            "placement_id": "1785700261650984_2495616093992727",
