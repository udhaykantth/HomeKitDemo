//
//  AddAccessoryViewController.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/14/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>

@class AddAccessoryViewController;
@protocol AddAccessoryViewControllerDelegate <NSObject>

@optional
-(void)AddAccessoryViewControllerDidCancel:(AddAccessoryViewController*)controller;

@end

@interface AddAccessoryViewController : UIViewController<HMAccessoryBrowserDelegate>
@property(nonatomic,weak)id <AddAccessoryViewControllerDelegate>delegate;
- (IBAction)cancel:(id)sender;



@end
