//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MKAnalytics/MKAnalytics.h>

@protocol GAITracker;

NS_ASSUME_NONNULL_BEGIN

@interface MKGoogleAnalyticsService : NSObject <MKAnalyticsService>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithGAITracker:(id<GAITracker>)tracker;

@end

NS_ASSUME_NONNULL_END
