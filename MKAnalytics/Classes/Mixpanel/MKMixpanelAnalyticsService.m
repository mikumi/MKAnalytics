//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import "MKMixpanelAnalyticsService.h"

#import <Mixpanel/Mixpanel.h>

//============================================================
//== Private Interface
//============================================================
@interface MKMixpanelAnalyticsService ()

@property (nonatomic, readonly, nonnull) Mixpanel *mixpanel;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKMixpanelAnalyticsService

#pragma mark - Life Cycle

- (instancetype)initWithMixpanel:(Mixpanel *)mixpanel
{
    self = [super init];
    if (self) {
        _mixpanel = mixpanel;
    }
    return self;
}

#pragma mark - MKAnalyticsService

- (void)identifyUserWithId:(NSString *)userId properties:(NSDictionary<NSString *, id> *)properties
{
    [self.mixpanel identify:userId];
    if (properties) {
        [self.mixpanel.people set:properties];
    }
}

- (void)aliasUser:(NSString *)alias
{
    [self.mixpanel createAlias:alias forDistinctID:self.mixpanel.distinctId];
    [self.mixpanel identify:self.mixpanel.distinctId];
}

- (void)setUserProperties:(NSDictionary<NSString *, id> *)properties
{
    [self.mixpanel.people set:properties];
}

- (void)resetIdentification
{
    [self.mixpanel reset];
    // If we don't identify with a new uuid, mixpanel will default to the IFA/IFV
    // See: https://blog.mixpanel.com/2015/09/21/community-tip-maintaining-user-identity/
    NSString *const uuid = [[NSUUID UUID] UUIDString];
    [self.mixpanel identify:uuid];
}

- (void)trackAppLaunched
{
    [self trackEvent:@"App launched" properties:nil];
}

- (void)trackScreen:(NSString *)screenName properties:(NSDictionary<NSString *, id> *)properties
{
    NSString *const eventName = [NSString stringWithFormat:@"Screen viewed - %@", screenName];
    [self trackEvent:eventName properties:properties];
}

- (void)trackEvent:(NSString *)event properties:(NSDictionary<NSString *, id> *)properties
{
    [self.mixpanel track:event properties:properties];
}

- (void)startTimingForEvent:(NSString *)event
{
    [self.mixpanel timeEvent:@"event"];
}

- (void)trackPurchase:(NSString *)item amount:(CGFloat)amount currency:(NSString *)currency
{
    // TODO: implement
}


@end
