//
//  HomeListATableViewController.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/19/15.
//  Copyright (c) 2015 Dh.Udhaykantth. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HomeKit;

@interface HomeListATableViewController : UITableViewController<HMHomeManagerDelegate>
@property (nonatomic,readwrite)HMHomeManager *homeManager;

@end
