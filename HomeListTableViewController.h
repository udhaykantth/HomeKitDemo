//
//  HomeListTableViewController.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/5/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

//#import "AddHomeViewController.h"

@interface HomeListTableViewController : UITableViewController<HMAccessoryBrowserDelegate,HMHomeManagerDelegate/*AddHomeViewControllerDelegate*/>

@end
