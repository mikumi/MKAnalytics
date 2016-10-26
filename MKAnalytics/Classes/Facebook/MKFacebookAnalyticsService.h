//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MKAnalytics/MKAnalytics.h>

@class FBSDKAppEvents;

NS_ASSUME_NONNULL_BEGIN

@interface MKFacebookAnalyticsService : NSObject <MKAnalyticsService>

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
