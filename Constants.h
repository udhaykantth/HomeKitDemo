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
#define ADD_HOME @"AddHome"

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
