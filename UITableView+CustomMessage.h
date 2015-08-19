//
//  UITableView+CustomMessages.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/19/15.
//  Copyright (c) 2015 Dh.Udhaykantth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CustomMessage)
/**
 *  Sets the receiver's backgroundView to a UILabel displaying the message provided, or clears
 *  it if the row count is not 0.
 *
 *  @param message  The message to display if rowCount is 0.
 *  @param rowCount The number of rows in the table. If it is 0, then the message
 will be displayed in the middle of the table, in gray.
 */
- (void)hkd_addMessage:(NSString *)message rowCount:(NSUInteger)rowCount;
@end
