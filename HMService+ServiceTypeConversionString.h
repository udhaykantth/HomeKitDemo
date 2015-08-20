//
//  HMService+ServiceTypeConversionString.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/20/15.
//  Copyright (c) 2015 Dh.Udhaykantth. All rights reserved.
//

#import <HomeKit/HomeKit.h>

@interface HMService (ServiceTypeConversionString)
@property (nonatomic, readonly) NSString *hkd_customizedServiceType;
+ (NSString *)hkd_customizedDescriptionForServiceType:(NSString *)serviceType;


@end
