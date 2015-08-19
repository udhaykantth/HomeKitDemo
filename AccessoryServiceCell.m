//
//  AccessoryServiceCell.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/19/15.
//  Copyright (c) 2015 Dh.Udhaykantth. All rights reserved.
//

#import "AccessoryServiceCell.h"

@implementation AccessoryServiceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 *  Sets the name of the cell to the service name, and
 *  The detail text to a description of where that service lives in the home.
 */
- (void)setService:(HMService *)service {
    _service = service;
    
    self.textLabel.text = service.name ?: service.accessory.name;
    NSString *formatString = NSLocalizedString(@"%@ in %@", @"Accessory in Room");
    NSString *accessoryName = service.accessory.name;
    NSString *roomName = service.accessory.room.name;
    self.detailTextLabel.text = [NSString stringWithFormat:formatString, accessoryName, roomName];
}

@end
