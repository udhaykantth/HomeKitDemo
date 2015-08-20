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
#import "UITableView+CustomMessage.h"
#import <HomeKit/HomeKit.h>

@interface NSDictionary(SortedKeys)
@property(nonatomic,readonly) NSArray *sortedKeys;
@end
@implementation NSDictionary(SortedKeys)

-(NSArray*)sortedKeys {
    return [self.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

@end


@interface AccessoryListViewController ()<HMHomeDelegate,HMAccessoryDelegate>
@property (nonatomic,strong) HMAccessory *accessory;
@property (nonatomic,strong) NSDictionary *serviceInfoList;
@property (nonatomic,strong) NSArray *sortedServiceInfoListKey;
@property (nonatomic,strong) NSArray *allAccessories;
@property (nonatomic,strong) NSArray *hkd_allServices;
@end

@implementation AccessoryListViewController
#pragma  mark -- custom methods

- (NSDictionary *)configureServiceDictionary {
      NSMutableDictionary *serviceDictionary = [NSMutableDictionary dictionary];
    
        //iterate all services from the all accessories present in home
    for (HMService *service in self.hkd_allServices) {
        
        NSString *typeOfService = nil;
        /*if ([service.serviceType isEqualToString:HMServiceTypeAccessoryInformation]) {
            typeOfService = HMServiceTypeAccessoryInformation;
        } else
         */
        if([service.serviceType isEqualToString:HMServiceTypeAccessoryInformation])
            { continue;
            }
            if ([service.serviceType isEqualToString:HMServiceTypeLightbulb]) {
            typeOfService = HMServiceTypeLightbulb;
        } else if ([service.serviceType isEqualToString:HMServiceTypeSwitch]){
            typeOfService = HMServiceTypeSwitch;
        } else if ([service.serviceType isEqualToString:HMServiceTypeThermostat]) {
            typeOfService = HMServiceTypeThermostat;
        } else if ([service.serviceType isEqualToString:HMServiceTypeGarageDoorOpener]) {
            typeOfService = HMServiceTypeGarageDoorOpener;
        } else if ([service.serviceType isEqualToString:HMServiceTypeFan]) {
            typeOfService = HMServiceTypeFan;
        } else if ([service.serviceType isEqualToString:HMServiceTypeOutlet]) {
            typeOfService = HMServiceTypeOutlet;
        } else if ([service.serviceType isEqualToString:HMServiceTypeLockMechanism]) {
            typeOfService = HMServiceTypeLockMechanism;
        }
        else if ([service.serviceType isEqualToString:HMServiceTypeLockManagement]) {
            typeOfService = HMServiceTypeLockManagement;
        }
        
            //grab existing list or create new list to store services to respective service type
        
        
            NSMutableArray *servicesInDictionary = serviceDictionary[typeOfService] ?: [NSMutableArray array];
        
            // Add the current service to the list of matching services.
        [servicesInDictionary addObject:service];
        
            // Reset the existing services in the dictionary.
        serviceDictionary[typeOfService] = servicesInDictionary;
    }
    return [NSDictionary dictionaryWithDictionary:serviceDictionary];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _allAccessories = self.home.accessories;
    if ([_allAccessories count]> 0) {
        [self resetAccessories];
    }
    
    
   /*
    NSLog(@"accessory count:%lu",(unsigned long)[_allAccessories count]);
    for (HMAccessory *accessory in _allAccessories) {
        NSLog(@"****************accessory start *************************");

        for (HMService *service in accessory.services) {
            NSLog(@"service count:%lu",[accessory.services count]);
            NSLog( @"service for %@ are service name :%@,servicetype:%@,serviceAccessory:%@,associatedServicetype:%@",accessory,service.name,service.serviceType,service.accessory,service.associatedServiceType);
        }
        NSLog(@"****************accessory end *************************");
    


    }
    */
}
-(void)viewWillAppear:(BOOL)animated
{[super viewWillAppear:animated];
}
-(void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}
-(void)dealloc {

PRINT_CONSOLE_LOG(nil)
}
#pragma mark - Table View
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString* title = _sortedServiceInfoListKey[section];
    if (title == nil && [title length] == 0) {
        return nil;
    }
    return title;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSUInteger sections = [self.sortedServiceInfoListKey count];
    [self.tableView hkd_addMessage:[self showMessage] rowCount:sections];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    
    return [_serviceInfoList[title] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMService *service = [self accessoryServiceForIndexPath:indexPath];
    AccessoryServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:ACCESSORY_SERVICE_CELL forIndexPath:indexPath];
    
    
    cell.service = service;
    return cell;
}
-(HMService*)accessoryServiceForIndexPath :(NSIndexPath*)indexPath{
    NSString *title = [self tableView:self.tableView titleForHeaderInSection:indexPath.section];
    HMService *service =  _serviceInfoList[title] [indexPath.row ];
    return service;
}

#pragma mark --Custom Messages

-(NSString*)showMessage {
    if ([self.home.accessories count]==0) {
        return @"No Accessory Found";
    }
    else
        { return @"No Services Found";
        }
    return nil;
}
#pragma mark --HMHomeDelegate
-(void)home:(HMHome *)home didAddAccessory:(HMAccessory *)accessory {
    [self reloadAccessoryListTable];
}
-(void)home:(HMHome *)home didRemoveAccessory:(HMAccessory *)accessory {
    [self reloadAccessoryListTable];

}
#pragma mark - HMAccessoryDelegate
-(void)accessory:(HMAccessory *)accessory didUpdateAssociatedServiceTypeForService:(HMService *)service
{
    [self reloadAccessoryListTable];

}
-(void)accessory:(HMAccessory *)accessory didUpdateNameForService:(HMService *)service {
    [self reloadAccessoryListTable];

}
-(void)accessoryDidUpdateName:(HMAccessory *)accessory {
    [self reloadAccessoryListTable];

    [self reloadAccessoryListTable];

}
-(void)accessoryDidUpdateReachability:(HMAccessory *)accessory {
    [self reloadAccessoryListTable];

}
-(void) accessoryDidUpdateServices:(HMAccessory *)accessory {
    [self reloadAccessoryListTable];

}
#pragma mark --TODO:// reset accessories?
-(void)resetAccessories {
    _serviceInfoList = [self configureServiceDictionary];
    _sortedServiceInfoListKey = _serviceInfoList.sortedKeys;
    for (HMAccessory *accessory in self.home.accessories ) {
        [accessory setDelegate:self];
    }
    NSLog(@"_serviceInfoList :%@",_serviceInfoList);
}
-(void)reloadAccessoryListTable {
    [self resetAccessories];
    [self.tableView reloadData];

}
- (NSArray *)hkd_allServices {
        // Use KVC Collection Operators to isolate the individual services from all of the accessories.
        // Basically, concatenate each of the 'services' arrays.
        // https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/KeyValueCoding/Articles/CollectionOperators.html
    return [_allAccessories valueForKeyPath:@"@unionOfArrays.services"];
}
@end
