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
- (IBAction)addHome:(id)sender {
    PRINT_CONSOLE_LOG(nil)
    [self showAlert];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated { // Updates the appearance of the Edit|Done button item as necessary. Clients who override it must call super first.
    NSString *msg = [NSString stringWithFormat:@"%d",editing];
    PRINT_CONSOLE_LOG(msg);
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    self.navigationItem.rightBarButtonItem.enabled = !editing;

}

#pragma mark - viewController Methods
- (void)viewDidLoad {
    PRINT_CONSOLE_LOG(nil)
    [super viewDidLoad];
    self.homeManager = [[HMHomeManager alloc]init];
    [self.homeManager setDelegate:self];
    
    if (self.accessoryBrowser == nil) {
        self.accessoryBrowser = [[HMAccessoryBrowser alloc] init];
        [self.accessoryBrowser setDelegate:self];
        
    }
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    NSInteger homesCount = [[self.homeManager homes]count];
    self.navigationItem.leftBarButtonItem.enabled = !(homesCount == 0);

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
- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerForHomeChangeNotifications];
}

- (void)dealloc {
    [self unregisterForHomeChangeNotifications];
}
-(void)registerForHomeChangeNotifications {
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(homeStoreDidUpdateSharedHome)
                                                 name:HomeStoreDidChangeSharedHomeNotification
                                               object:[HomeStore sharedStore]];
     */
}
-(void)unregisterForHomeChangeNotifications {
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"homes count:%lu, editing :%d",(unsigned long)[self.homeManager.homes count],self.editing);
    NSInteger noOfHomes = [self.homeManager.homes count];
    self.navigationItem.leftBarButtonItem.enabled = (noOfHomes > 0);
    self.editButtonItem.enabled = (noOfHomes > 0);


    if (noOfHomes == 0 && self.editing) {
        [self.tableView setEditing:!self.editing animated:YES];
        self.navigationItem.rightBarButtonItem.enabled =!(noOfHomes > 0);
//        if (noOfHomes == 0) {
//            self.navigationItem.leftBarButtonItem = self.editButtonItem;
//            self.navigationItem.leftBarButtonItem.enabled = NO;
//        }
        
    }
    if (noOfHomes == 0) {
        [self.tableView setEditing:NO animated:YES];
        [self setEditing:NO animated:YES];

    }

    return noOfHomes;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRINT_CONSOLE_LOG(nil)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeList" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.homeManager.homes [indexPath.row]name];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    PRINT_CONSOLE_LOG(nil)
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PRINT_CONSOLE_LOG(nil)
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HMHome *deletingHome = self.homeManager.homes[indexPath.row];
        [self.homeManager removeHome:deletingHome completionHandler:^(NSError *error) {
            if (error != nil) {
                PRINT_CONSOLE_LOG(@"error in deleting home")
                //TODO: Show alert here.
            }
            else
            {
                // Delete the row from the data source
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
            }
        }];
         } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
/*
#pragma mark - AddHomeViewControllerDelegate
-(void)addHomeViewControllerDidSave:(AddHomeViewController *)controller
{
    PRINT_CONSOLE_LOG(nil)
    NSLog(@"newly added home:%@",controller.homeText);

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void) addHomeViewControllerDidCancel:(AddHomeViewController *)controller
{
    PRINT_CONSOLE_LOG(nil)
    [self dismissViewControllerAnimated:YES completion:nil];

}
 */
/*
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
*/
-(void)showAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Add Home",nil)]
                                                                             message:NSLocalizedString(@"Enter a name.", @"Enter a name.")
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Home name ";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"cancel tapped");
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    NSString *addString = [NSString stringWithFormat:@"%@", NSLocalizedString(@"Add",nil)];
    
    UIAlertAction *addNewObject = [UIAlertAction actionWithTitle:addString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"added..");
        NSString *newName = [alertController.textFields.firstObject text];
        NSString *trimmedName = [newName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"added string is:%@",trimmedName);
        if ([trimmedName length]>0) {
            [self addNewHome:trimmedName];
            [self refreshTable];
        }
        NSLog(@"added string :%@",[trimmedName length] > 0? trimmedName:@"Could not add");
 }];
    
    [alertController addAction:cancel];
    [alertController addAction:addNewObject];
    [self presentViewController:alertController animated:YES completion:nil];
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
   __weak typeof(self) weakSelf = self;
    
    
    [self.homeManager addHomeWithName:homeName completionHandler:^(HMHome *home, NSError *error)  {
        
        if (home == nil) {
            NSLog(@"Could not find the home");
            return ;
        }
        [weakSelf refreshTable];

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
