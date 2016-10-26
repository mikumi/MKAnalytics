//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//============================================================
//== MKAnalyticsService protocol
//============================================================
@protocol MKAnalyticsService <NSObject>

@required
- (void)identifyUserWithId:(NSString *)userId properties:(nullable NSDictionary<NSString *, id> *)properties;
- (void)aliasUser:(NSString *)alias;
- (void)setUserProperties:(NSDictionary<NSString *, id> *)properties;
- (void)resetIdentification;

- (void)trackAppLaunched;
- (void)trackScreen:(NSString *)screenName properties:(nullable NSDictionary<NSString *, id> *)properties;
- (void)trackEvent:(NSString *)event properties:(nullable NSDictionary<NSString *, id> *)properties;

- (void)startTimingForEvent:(NSString *)event;

- (void)trackPurchase:(NSString *)item amount:(CGFloat)amount currency:(NSString *)currency;

@end

//============================================================
//== Public Interface
//============================================================
@interface MKAnalytics : NSObject <MKAnalyticsService>

@property (nonatomic) NSArray<id<MKAnalyticsService>> *analyticsServices;

+ (MKAnalytics *)defaultAnalytics;
+ (instancetype)analyticsWithServices:(NSArray <id<MKAnalyticsService>> *)services;

- (instancetype)init;

- (void)identifyUserWithId:(NSString *)userId;
- (void)trackScreen:(NSString *)screenName;
- (void)trackEvent:(NSString *)event;

@end

NS_ASSUME_NONNULL_END
