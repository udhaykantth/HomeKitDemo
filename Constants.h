//
//  Constants.h
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/5/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#ifndef HomeKitDemo_Constants_h
#define HomeKitDemo_Constants_h


 

//AddHomeViewController Constants
#define ADD_HOME                    @"AddHome"
#define ROOM_LIST                   @"RoomList"
#define ADD_ACCESSORY_SEQUE         @"AddAccessorySegue"
#define ACCESSORY_SEGUE             @"AccessorySegue"

#define HOME_LIST_IDENTIFIER_CELL     @"HomeList"
#define ADD_ACCESSORY_IDENTIFIER_CELL @"AddAccessoryCell"
#define DEFAULT_ACCESSORY_CELL        @"DefaultAccessoryCell"
#define DEFAULT_ACCESSORY_CELL_TEXT   @"searching..."
#define NO_FOUND_ACCESSORY_CELL_TEXT  @"No Discovered Accessories"
#define HEADER_SECTION_TITLE          @"select accessory"
#define HOME_LIST_A_IDENTIFIER_CELL   @"HomeListA"
#define ACCESSORY_SERVICE_SEGUE       @"AccessoryServiceSegue"
#define ACCESSORY_SERVICE_CELL       @"AccessoryServiceCell"

//Print Logs
#ifdef DEBUG
#define PRINT_CONSOLE_LOG(message)  \
if(message!=nil) \
NSLog(@"[%@ %@]-[Debug message:%@]",[self class],NSStringFromSelector(_cmd),message);\
else \
NSLog(@"[%@ %@]",[self class],NSStringFromSelector(_cmd));
#else
#define PRINT_CONSOLE_LOG(...) NSLog(@"[%@ %@]",[self class],NSStringFromSelector(_cmd));
#endif

#endif
