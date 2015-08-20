//
//  HMService+ServiceTypeConversionString.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/20/15.
//  Copyright (c) 2015 Dh.Udhaykantth. All rights reserved.
//

#import "HMService+ServiceTypeConversionString.h"
static NSDictionary *_serviceTypeDict;

@implementation HMService (ServiceTypeConversionString)
    //TODO:: when initialized is called.?
+ (void)initialize {
    _serviceTypeDict = @{ HMServiceTypeLightbulb: NSLocalizedString(@"Lightbulb", @"Lightbulb"),
                         HMServiceTypeSwitch: NSLocalizedString(@"Switch", @"Switch"),
                         HMServiceTypeThermostat: NSLocalizedString(@"Thermostat", @"Thermostat"),
                         HMServiceTypeGarageDoorOpener: NSLocalizedString(@"Garage Door Opener", @"Garage Door Opener"),
                         HMServiceTypeAccessoryInformation: NSLocalizedString(@"Accessory Information", @"Accessory Information"),
                         HMServiceTypeFan: NSLocalizedString(@"Fan", @"Fan"),
                         HMServiceTypeOutlet: NSLocalizedString(@"Outlet", @"Outlet"),
                         HMServiceTypeLockMechanism: NSLocalizedString(@"Lock Mechanism", @"Lock Mechanism"),
                         HMServiceTypeLockManagement: NSLocalizedString(@"Lock Management", @"Lock Management") };
}
+ (NSString *)hkd_customizedDescriptionForServiceType:(NSString *)serviceType {
    return _serviceTypeDict[serviceType];
}

- (NSString *)hkd_customizedServiceType {
     return [self.class hkd_customizedDescriptionForServiceType:self.serviceType] ?: self.serviceType;
}
@end
