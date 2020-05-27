//
//  IMFacadeObjectHolder.h
//  InMobiMoPubPlugin
//
//  Copyright © 2020 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <InMobiSDK/InMobiSDK.h>

NS_ASSUME_NONNULL_BEGIN

#define kIMABInMobiObjectKey @"IMABInMobiObject"

@interface IMFacadeObjectHolder : NSObject

@property(nonatomic, weak) id imAd;
@property(nonatomic, weak) id mpAd;

- (instancetype)initWithMoPubObject:(nullable id)mpAd andInMobiObject:(id)imAd;

@end

NS_ASSUME_NONNULL_END
