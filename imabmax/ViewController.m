//
//  ViewController.m
//  imabmax
//
//  Created by Jason C on 3/26/20.
//  Copyright © 2020 Jason C. All rights reserved.
//

#import "ViewController.h"
@import AdSupport;


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *maxSDKVersionDisplay;
@property (weak, nonatomic) IBOutlet UILabel *imSDKVersionDisplay;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // [self identifierForAdvertising];
    
    [self.maxSDKVersionDisplay setText:[ALSdk version]];
}




- (NSString *)identifierForAdvertising {
    // Check whether advertising tracking is enabled
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSUUID *identifier = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        
        return [identifier UUIDString];
    }

    // Get and return IDFA
    return nil;
}
- (IBAction)loadBannerAd:(id)sender {
}
- (IBAction)loadBannerTest:(id)sender {
}

- (IBAction) myUnwindAction:(UIStoryboardSegue*)unwindSegue {
 
    // do something
}


@end
