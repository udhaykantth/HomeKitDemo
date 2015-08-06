//
//  HomeStore.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/6/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>
extern NSString *const HomeStoreDidChangeSharedHomeNotification;
extern NSString *const HomeStoreDidUpdateHomesNotification;


@interface HomeStore : NSObject <HMHomeManagerDelegate>
@property(nonatomic,strong) HMHome *home;
@property (nonatomic,strong)HMHomeManager *homeManager;
+(instancetype) sharedHomeStore;


@end
