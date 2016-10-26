//
// Created by Michael Kuck on 10/25/16.
// Copyright (c) 2016 Jaysquared. All rights reserved.
//

#import "MKGoogleAnalyticsService.h"

#import <GoogleAnalytics/GAITracker.h>
#import <GoogleAnalytics/GAIFields.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>

//============================================================
//== ObjectOrNil helper method
//============================================================
@implementation NSObject (ObjectOrNil)

- (id)objectOfClassOrNil:(Class)ofClass {
    if ([self isKindOfClass:ofClass]) {
        return self;
    } else {
        return nil;
    }
}

@end

//============================================================
//== Private Interface
//============================================================
@interface MKGoogleAnalyticsService ()

@property (nonatomic, readonly, nonnull) id <GAITracker> tracker;
@property (nonatomic, readonly, nonnull) NSMutableDictionary<NSString *, NSNumber *> *eventStartTimes;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKGoogleAnalyticsService

#pragma mark - Life Cycle

- (instancetype)initWithGAITracker:(id <GAITracker>)tracker
{
    self = [super init];
    if (self) {
        _tracker = tracker;
    }
    return self;
}

#pragma mark - MKAnalyticsService

- (void)identifyUserWithId:(NSString *)userId properties:(NSDictionary<NSString *, id> *)properties
{
    // Storing user properties is not supported by Google Analytics
    [self.tracker set:kGAIUserId value:userId];
}

- (void)aliasUser:(NSString *)alias
{
    // Aliasing is not supported by Google Analytics
    [self.tracker set:kGAIUserId value:alias];
}

- (void)setUserProperties:(NSDictionary<NSString *, id> *)properties
{
    // Storing user properties is not supported by Google Analytics
}

- (void)resetIdentification
{
    [self.tracker set:kGAIUserId value:nil];
}

- (void)trackAppLaunched
{
    [self trackEvent:@"App launched" properties:nil];
}

- (void)trackScreen:(NSString *)screenName properties:(NSDictionary<NSString *, id> *)properties
{
    // Screen properties are not supported by Google Analytics
    [self.tracker set:kGAIScreenName value:screenName];
    [self.tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)trackEvent:(NSString *)event properties:(NSDictionary<NSString *, id> *)properties
{
    NSString *const category = [properties[@"category"] objectOfClassOrNil:[NSString class]];
    NSString *const label = [properties[@"label"] objectOfClassOrNil:[NSString class]];
    NSNumber *const value = [properties[@"value"] objectOfClassOrNil:[NSNumber class]];

    NSNumber *const eventStartTime = self.eventStartTimes[event];
    if (eventStartTime) {
        self.eventStartTimes[event] = nil;
        NSTimeInterval const timeDiff = CFAbsoluteTimeGetCurrent() - eventStartTime.doubleValue;
        NSNumber *const timeDiffMillis = @(timeDiff * 1000);
        [self.tracker send:[[GAIDictionaryBuilder createTimingWithCategory:category interval:timeDiffMillis
                                                                      name:event label:label] build]];
    } else {
        [self.tracker send:[[GAIDictionaryBuilder createEventWithCategory:category action:event label:label
                                                                    value:value] build]];
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
