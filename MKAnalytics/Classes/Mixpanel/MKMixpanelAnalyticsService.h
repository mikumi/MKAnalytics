//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MKAnalytics/MKAnalytics.h>

@class Mixpanel;

NS_ASSUME_NONNULL_BEGIN

@interface MKMixpanelAnalyticsService : NSObject <MKAnalyticsService>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMixpanel:(Mixpanel *)mixpanel;

@end

NS_ASSUME_NONNULL_END
