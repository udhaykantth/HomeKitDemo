//
//  HomeListTableViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/5/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "HomeListTableViewController.h"
#import "Constants.h"

 
@interface HomeListTableViewController ()
@property (nonatomic,strong) HMHome *home;
@property (nonatomic,strong) HMRoom *room;
@property (nonatomic,strong) NSArray *accessories;
@property (nonatomic,strong) HMAccessoryBrowser *accessoryBrowser;
@property (nonatomic,strong) HMHomeManager *homeManager;
@property (nonatomic,strong) NSString *roomName;
-(NSString*) randomHomeName;
@end

@implementation HomeListTableViewController
-(NSString*) randomHomeName {
    return  [NSString stringWithFormat:@"Home/%d",(arc4random_uniform(UINT32_MAX))];
} 

- (void)viewDidLoad {
    PRINT_CONSOLE_LOG(nil)
    [super viewDidLoad];
    self.homeManager = [[HMHomeManager alloc]init];
    [self.homeManager setDelegate:self];
    
    if (self.accessoryBrowser == nil) {
        self.accessoryBrowser = [[HMAccessoryBrowser alloc] init];
        [self.accessoryBrowser setDelegate:self];
        
    }
    //self.roomName =@"Lobby";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"homes count:%lu",(unsigned long)[self.homeManager.homes count]);
    return [self.homeManager.homes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRINT_CONSOLE_LOG(nil)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeList" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.homeManager.homes [indexPath.row]name];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - AddHomeViewControllerDelegate
-(void)addHomeViewControllerDidSave:(AddHomeViewController *)controller
{
    PRINT_CONSOLE_LOG(nil)
    NSLog(@"newly added home:%@",controller.homeText);
    [self addNewHome:controller.homeText];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void) addHomeViewControllerDidCancel:(AddHomeViewController *)controller
{
    PRINT_CONSOLE_LOG(nil)
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark segue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:ADD_HOME]) {
        PRINT_CONSOLE_LOG(nil)

        AddHomeViewController* addHomeViewController = (AddHomeViewController*) segue.destinationViewController;
        [addHomeViewController setDelegate:self];
        [addHomeViewController setHomeManager:self.homeManager];
        
    }
}

-(void) findCharacteristicsOfService:(HMService*)service {
    PRINT_CONSOLE_LOG(nil)
    for (HMCharacteristic* characteristic in service.characteristics ) {
        NSLog(@"characteristic type = %@",characteristic.characteristicType);
    }
    
}
-(void) findServicesForAccessory:(HMAccessory*) accessory {
    PRINT_CONSOLE_LOG(nil)
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
    PRINT_CONSOLE_LOG(nil)
    NSLog(@"manager:%lu",(unsigned long)[manager.homes count]);
    [self refreshTable];
    
}


- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager {
    PRINT_CONSOLE_LOG(nil)
}

- (void)homeManager:(HMHomeManager *)manager didAddHome:(HMHome *)home {
    PRINT_CONSOLE_LOG(nil)
}


- (void)homeManager:(HMHomeManager *)manager didRemoveHome:(HMHome *)home {
    PRINT_CONSOLE_LOG(nil)
    
}


#pragma mark - HMAccessoryBrowserDelegate
-(void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory
{ PRINT_CONSOLE_LOG(nil)
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
{ PRINT_CONSOLE_LOG(nil)
    NSLog(@"An accessory has been removed");
    
}
-(void)refreshTable
{
    [self.tableView reloadData];
}
-(void)addNewHome:(NSString*)homeName {
//    __weak typeof(self) weakSelf = self;
    
    
    [self.homeManager addHomeWithName:homeName completionHandler:^(HMHome *home, NSError *error)  {
        
        if (home == nil) {
            NSLog(@"Could not find the home");
            return ;
        }
        
         NSLog(@"successfully found home");
        /*
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
        
        */
        
        
    }];

}

@end
