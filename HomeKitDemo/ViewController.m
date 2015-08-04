//
//  ViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 7/17/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "ViewController.h"
#define PRINT_CONSOLE_LOG NSLog(@"[%@ %@]",[self class],NSStringFromSelector(_cmd));


@interface ViewController ()

@property (nonatomic,strong) HMHome *home;
@property (nonatomic,strong) HMRoom *room;
@property (nonatomic,strong) NSArray *accessories;
@property (nonatomic,strong) HMAccessoryBrowser *accessoryBrowser;
@property (nonatomic,strong) HMHomeManager *homeManager;
@property (nonatomic,strong) NSString *roomName;
-(NSString*) randomHomeName;

@end


@implementation ViewController
-(NSString*) randomHomeName {
    return  [NSString stringWithFormat:@"Home/%d",(arc4random_uniform(UINT32_MAX))];
}
- (IBAction)DiscoverAccessories:(id)sender {
    PRINT_CONSOLE_LOG
    if (self.accessoryBrowser == nil) {
        self.accessoryBrowser = [[HMAccessoryBrowser alloc] init];
        [self.accessoryBrowser setDelegate:self];
 
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.homeManager = [[HMHomeManager alloc]init];
    [self.homeManager setDelegate:self];
    //self.roomName =@"Lobby";
}
-(void)viewDidDisappear:(BOOL)animated

{
    [super viewDidDisappear:animated];
    [self.accessoryBrowser stopSearchingForNewAccessories];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) findCharacteristicsOfService:(HMService*)service {
     PRINT_CONSOLE_LOG
    for (HMCharacteristic* characteristic in service.characteristics ) {
        NSLog(@"characteristic type = %@",characteristic.characteristicType);
    }
    
}
-(void) findServicesForAccessory:(HMAccessory*) accessory {
    PRINT_CONSOLE_LOG
    NSLog(@"Finding services for this accessory...");
    
    for (HMService* service in accessory.services)
    {
        NSLog(@" Service name = %@",service.name);
        NSLog(@" Service type = %@",service.serviceType);
        NSLog(@" Finding the characteristics for this service...");
              [self findCharacteristicsOfService:service];
    
    }
    
}

    
#pragma mark-- HMHomeManagerDelegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager {
      PRINT_CONSOLE_LOG
    __weak typeof(self) weakSelf = self;
    
    [self.homeManager addHomeWithName:@"myHome" completionHandler:^(HMHome *home, NSError *error)  {
       
        if (home == nil) {
            NSLog(@"Could not find the home");
            return ;
        }
        
        weakSelf.home = home;
        NSLog(@"successfully found home");
        [weakSelf.home addRoomWithName:weakSelf.roomName completionHandler:^(HMRoom *room, NSError *error) {
            if (error !=nil) {
                NSLog(@"Failed to add a room....");
            }
            else {
                weakSelf.room = room;
                NSLog(@"Successfully added a room....");
                [weakSelf.accessoryBrowser startSearchingForNewAccessories];
                NSLog(@"Discovering accessories now...");
                
                
            }
        }];
        
        
    }];

    
} 


- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager {
PRINT_CONSOLE_LOG
}

- (void)homeManager:(HMHomeManager *)manager didAddHome:(HMHome *)home {
PRINT_CONSOLE_LOG
}


- (void)homeManager:(HMHomeManager *)manager didRemoveHome:(HMHome *)home {
PRINT_CONSOLE_LOG
    
}


#pragma mark - HMAccessoryBrowserDelegate
-(void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory
{ PRINT_CONSOLE_LOG
    __weak typeof(self) weakSelf = self;

    NSLog(@"Found a new accessory");
    NSLog(@"Adding it to the home...");
    [self.home addAccessory:accessory completionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Failed to add the accessory to the home");
            NSLog(@"Error = %@",[error description]);
        }
        else
        {
            [weakSelf.home assignAccessory:accessory toRoom:weakSelf.room completionHandler:^(NSError *error) {
                if (error != nil){
                    NSLog(@"Failed to assign the accessory to the room");
                    NSLog(@"Error = \(error)");
                } else {
                    NSLog(@"Successfully assigned the accessory to the room");
                    
                    [weakSelf findServicesForAccessory:accessory];
                    
                }
                
            }];
        }
        
    }];
    


}
-(void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory
{ PRINT_CONSOLE_LOG
    NSLog(@"An accessory has been removed");

}

 
@end

