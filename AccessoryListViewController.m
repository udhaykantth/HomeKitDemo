//
//  AccessoryListViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/19/15.
//  Copyright (c) 2015 Dh.Udhaykantth. All rights reserved.
//

#import "AccessoryListViewController.h"
#import "Constants.h"
#import "AccessoryServiceCell.h"
@interface AccessoryListViewController ()
@property (nonatomic,strong) HMAccessory *accessory;
@property (nonatomic,strong) NSArray *allAccessories;
@end

@implementation AccessoryListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _allAccessories = self.home.accessories;
    for (HMAccessory *accessory in _allAccessories) {
        for (HMService *service in accessory.services) {
            NSLog( @"service for %@ are service name :%@,servicetype:%@,serviceAccessory:%@,associatedServicetype:%@",accessory,service.name,service.serviceType,service.accessory,service.associatedServiceType);
        }
        NSLog(@"*******");

    }
}
-(void)viewWillAppear:(BOOL)animated
{[super viewWillAppear:animated];
}
-(void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}
#pragma mark - Table View
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        //_allAccessories objectAtIndex:section
    return nil;//TODO

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_allAccessories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccessoryServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:ACCESSORY_SERVICE_CELL forIndexPath:indexPath];
    
    HMAccessory *accessoryObj = _allAccessories[indexPath.row];
    cell.textLabel.text = [accessoryObj name];
    return cell;
}



 
@end
