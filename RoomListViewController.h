//
//  RoomListViewController.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/11/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@interface RoomListViewController : UITableViewController<HMHomeDelegate>
@property(nonatomic,strong)HMHome *home;
@property(nonatomic,strong)HMHomeManager *homeManager;

@end
