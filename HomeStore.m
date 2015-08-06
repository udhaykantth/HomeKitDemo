//
//  HomeStore.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/6/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "HomeStore.h"
#import "Constants.h"
NSString *const HomeStoreDidChangeSharedHomeNotification = @"HomeStoreDidChangeSharedHomeNotification";
NSString *const HomeStoreDidUpdateHomesNotification = @"HomeStoreDidUpdateHomesNotification";
NSString *const HomeStoreDidUpdatePrimaryHomeNotification = @"HomeStoreDidUpdatePrimaryHomeNotification";
//NSString *const HomeStoreDidUpdatePrimaryHomeNotification = @"HomeStoreDidUpdatePrimaryHomeNotification";
NSString *const HomeStoreDidRemoveHomeNotification = @"HomeStoreDidRemoveHomeNotification";


@implementation HomeStore
@synthesize homeManager,home;

+(instancetype)sharedHomeStore {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return  sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        homeManager = [HMHomeManager new];
        [homeManager setDelegate:self];
    }
    return nil;
}
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager {
    PRINT_CONSOLE_LOG(nil)
    [[NSNotificationCenter defaultCenter]postNotificationName:HomeStoreDidUpdateHomesNotification object:self];

}
- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager {
    PRINT_CONSOLE_LOG(nil)
[[NSNotificationCenter defaultCenter]postNotificationName:HomeStoreDidUpdatePrimaryHomeNotification object:self];
}

- (void)homeManager:(HMHomeManager *)manager didAddHome:(HMHome *)home {
    PRINT_CONSOLE_LOG(nil)

}

- (void)homeManager:(HMHomeManager *)manager didRemoveHome:(HMHome *)home {
    PRINT_CONSOLE_LOG(nil)
    [[NSNotificationCenter defaultCenter]postNotificationName:HomeStoreDidUpdateHomesNotification object:self];


}

@end
