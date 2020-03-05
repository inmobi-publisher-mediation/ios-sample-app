//
//  ViewController.h
//  imabmopub
//
//  Created by Jason C on 2/11/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoPub.h"
#import <InMobiSDK/InMobiSDK.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *MoPubSDKVersion;
@property (weak, nonatomic) IBOutlet UILabel *InMobiSDKVersion;

@end

