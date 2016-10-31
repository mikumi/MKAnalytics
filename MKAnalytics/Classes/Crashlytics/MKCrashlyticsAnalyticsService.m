//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import <Crashlytics/Crashlytics/Crashlytics.h>
#import "MKCrashlyticsAnalyticsService.h"

//============================================================
//== Private Interface
//============================================================
@interface MKCrashlyticsAnalyticsService ()

@property (nonatomic, readonly, nonnull) Crashlytics *crashlytics;
@property (nonatomic, readonly, nonnull) NSMutableDictionary<NSString *, NSNumber *> *eventStartTimes;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKCrashlyticsAnalyticsService

#pragma mark - Life Cycle

- (instancetype)initWithCrashlytics:(Crashlytics *)crashlytics
{
    self = [super init];
    if (self) {
        _crashlytics = crashlytics;
    }
    return self;
}

#pragma mark - MKAnalyticsService

- (void)identifyUserWithId:(NSString *)userId properties:(NSDictionary<NSString *, id> *)properties
{
    [self.crashlytics setUserIdentifier:userId];
    [self setUserProperties:properties];
}

- (void)aliasUser:(NSString *)alias
{
    [self identifyUserWithId:alias properties:nil];
}

- (void)setUserProperties:(NSDictionary<NSString *, id> *)properties
{
    if ([properties.allKeys containsObject:@"email"]) {
        [self.crashlytics setUserEmail:properties[@"email"]];
    }
    if ([properties.allKeys containsObject:@"username"]) {
        [self.crashlytics setUserEmail:properties[@"username"]];
    }
    // Storing user properties is not supported by Google Analytics
}

- (void)resetIdentification
{
    [self.crashlytics setUserIdentifier:nil];
    [self.crashlytics setUserEmail:nil];
    [self.crashlytics setUserIdentifier:nil];
}

- (void)trackAppLaunched
{
    // Not necessary to track as Crashlytics already does that
}

- (void)trackScreen:(NSString *)screenName properties:(NSDictionary<NSString *, id> *)properties
{
    NSString *const eventName = [NSString stringWithFormat:@"Screen viewed - %@", screenName];
    [self trackEvent:eventName properties:properties];
}

- (void)trackEvent:(NSString *)event properties:(NSDictionary<NSString *, id> *)properties
{
    NSNumber *const eventStartTime = self.eventStartTimes[event];
    if (eventStartTime) {
        self.eventStartTimes[event] = nil;
        NSTimeInterval const timeDiff = CFAbsoluteTimeGetCurrent() - eventStartTime.doubleValue;
        NSNumber *const timeDiffMillis = @(timeDiff * 1000);
        NSMutableDictionary *const updatedPropeties = [NSMutableDictionary dictionaryWithDictionary:properties];
        updatedPropeties[@"duration"] = timeDiffMillis;
        [Answers logCustomEventWithName:event customAttributes:updatedPropeties];
    } else {
        [Answers logCustomEventWithName:event customAttributes:properties];
    }
}

- (void)startTimingForEvent:(NSString *)event
{
    self.eventStartTimes[event] = @(CFAbsoluteTimeGetCurrent());
}

- (void)trackPurchase:(NSString *)item amount:(CGFloat)amount currency:(NSString *)currency
{
    // TODO: implement
}

@end
