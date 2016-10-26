//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import "MKFacebookAnalyticsService.h"

#import <FBSDKCoreKit/FBSDKAppEvents.h>

//============================================================
//== Private Interface
//============================================================
@interface MKFacebookAnalyticsService ()

@property (nonatomic, readonly, nonnull) NSMutableDictionary<NSString *, NSNumber *> *eventStartTimes;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKFacebookAnalyticsService

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - MKAnalyticsService

- (void)identifyUserWithId:(NSString *)userId properties:(NSDictionary<NSString *, id> *)properties
{
    // Identities are not supported by Facebook Analytics
}

- (void)aliasUser:(NSString *)alias
{
    // Aliases are not supported by Facebook Analytics
}

- (void)setUserProperties:(NSDictionary<NSString *, id> *)properties
{
    // User properties are not supported by Facebook Analytics
}

- (void)resetIdentification
{
    // User identity are not supported by Facebook Analytics
}

- (void)trackAppLaunched
{
    // Not necessary to track as Facebook automatically tracks launches
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
        [FBSDKAppEvents logEvent:event parameters:updatedPropeties];
    } else {
        [FBSDKAppEvents logEvent:event parameters:properties];
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
