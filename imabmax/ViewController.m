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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // [self identifierForAdvertising];
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


@end
