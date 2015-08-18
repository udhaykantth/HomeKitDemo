//
//  AccessoryViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/17/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "AccessoryViewController.h"
#import "Constants.h"
@interface AccessoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;


@end

@implementation AccessoryViewController

-(void)viewDidLoad {
    PRINT_CONSOLE_LOG(nil)
    [super viewDidLoad];
    NSString *title = self.accessory.name;
    if ([title length]> 0 ) {
        [self setTitle:title];
        NSString *descriptionText  = [NSString stringWithFormat:@"You need the unique Homekit Setup Code of %@ to securely add it to your home.",title];
        [self.descriptionLbl setText:descriptionText] ;

    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PRINT_CONSOLE_LOG(nil)

}
-(void)viewDidAppear:(BOOL)animated {
    PRINT_CONSOLE_LOG(nil)
    [super viewDidAppear:animated];


}
-(void)dealloc
{
    PRINT_CONSOLE_LOG(nil)


}

- (IBAction)identifyAccessory:(id)sender {
    PRINT_CONSOLE_LOG(nil)
}
- (IBAction)addToHome:(id)sender {
    PRINT_CONSOLE_LOG(nil)
   self.home = self.homeManager.primaryHome;
    __weak typeof(self) weakSelf = self;

    [self.home addAccessory:self.accessory completionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"error occured , unable to add accessory");
        }
        else
            {
            NSLog(@"successfully added accessory:%@",weakSelf.accessory.name);
            }
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
    }];
}

@end
