//
//  AddHomeViewController.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/5/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HomeKit/HomeKit.h>
@class AddHomeViewController;
@protocol AddHomeViewControllerDelegate <NSObject>

@optional
-(void)addHomeViewControllerDidCancel:(AddHomeViewController*)controller;
-(void)addHomeViewControllerDidSave:(AddHomeViewController*)controller;

@end

@interface AddHomeViewController : UIViewController 
@property(nonatomic,weak)id <AddHomeViewControllerDelegate>delegate;
@property(nonatomic,strong) HMHomeManager *homeManager;
@property(nonatomic,strong) NSString* homeText;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
