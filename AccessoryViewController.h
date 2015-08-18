//
//  AccessoryViewController.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/17/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@interface AccessoryViewController : UIViewController
@property(nonatomic,strong)HMAccessory  *accessory;
@property(nonatomic,strong)HMHome *home;
@property (nonatomic,strong)HMHomeManager *homeManager;



@end
