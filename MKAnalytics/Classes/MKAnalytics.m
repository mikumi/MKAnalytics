//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import "MKAnalytics.h"

@implementation MKAnalytics

#pragma mark - Life Cycle

+ (MKAnalytics *)defaultAnalytics
{
    static dispatch_once_t onceToken;
    static MKAnalytics *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MKAnalytics alloc] init];
    });
    return sharedInstance;
}

+ (instancetype)analyticsWithServices:(NSArray <id<MKAnalyticsService>> *)services
{
    MKAnalytics *const analytics = [[MKAnalytics alloc] init];
    analytics.analyticsServices = services;
    return analytics;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _analyticsServices = (NSArray <id<MKAnalyticsService>> *) @[];
    }
    return self;
}

#pragma mark - Public Implementation

- (void)identifyUserWithId:(NSString *)userId
{
    [self identifyUserWithId:userId properties:nil];
}


- (void)trackScreen:(NSString *)screenName
{
    [self trackScreen:screenName properties:nil];
}

- (void)trackEvent:(NSString *)event
{
    [self trackEvent:event properties:nil];
}

#pragma mark - MKAnalyticsService

- (void)identifyUserWithId:(NSString *)userId properties:(NSDictionary<NSString *, id> *)properties
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service identifyUserWithId:userId properties:properties];
    }
}

- (void)aliasUser:(NSString *)alias
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service aliasUser:alias];
    }
}

- (void)setUserProperties:(NSDictionary<NSString *, id> *)properties
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service setUserProperties:properties];
    }
}

- (void)resetIdentification
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service resetIdentification];
    }
}

- (void)trackAppLaunched
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service trackAppLaunched];
    }
}


- (void)trackScreen:(NSString *)screenName properties:(NSDictionary<NSString *, id> *)properties
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service trackScreen:screenName properties:properties];
    }
}

- (void)trackEvent:(NSString *)event properties:(NSDictionary<NSString *, id> *)properties
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service trackEvent:event properties:properties];
    }
}

- (void)startTimingForEvent:(NSString *)event
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service startTimingForEvent:event];
    }
}

- (void)trackPurchase:(NSString *)item amount:(CGFloat)amount currency:(NSString *)currency
{
    for (id<MKAnalyticsService> const service in [NSArray arrayWithArray:self.analyticsServices]) {
        [service trackPurchase:item amount:amount currency:currency];
    }
}


@end
