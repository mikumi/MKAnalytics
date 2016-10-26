//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MKAnalytics/MKAnalytics.h>

@class Crashlytics;

NS_ASSUME_NONNULL_BEGIN

@interface MKCrashlyticsAnalyticsService : NSObject <MKAnalyticsService>

- (instancetype)initWithCrashlytics:(Crashlytics *)crashlytics;

@end

NS_ASSUME_NONNULL_END
