//
//  RoomListViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/11/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "RoomListViewController.h"
#import "Constants.h"

@implementation RoomListViewController

#pragma mark - view LifeCycle 
-(void)viewDidLoad {
    
    [self.navigationItem setTitle:self.home.name];
    PRINT_CONSOLE_LOG(nil)
    PRINT_CONSOLE_LOG(self.home.name);

    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)awakeFromNib {
    [super awakeFromNib];
    PRINT_CONSOLE_LOG(nil)
 }

- (void)dealloc {
    PRINT_CONSOLE_LOG(nil)
 }
#pragma  mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"rooms count:%lu, editing :%d",(unsigned long)[self.home.rooms count],self.editing);
    NSInteger noOfRooms = [self.home.rooms count];
    
    if (noOfRooms == 0 && self.editing) {
        [self.tableView setEditing:!self.editing animated:YES];
        self.navigationItem.rightBarButtonItem.enabled =!(noOfRooms > 0);
        
        
    }
    if (noOfRooms == 0) {
        [self.tableView setEditing:NO animated:YES];
        [self setEditing:NO animated:YES];
        
    }
    
    return noOfRooms;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRINT_CONSOLE_LOG(nil)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomListTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.home.rooms [indexPath.row]name];
    
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
        HMRoom *deletingRoom = self.home.rooms[indexPath.row];
        [self.home removeRoom:deletingRoom completionHandler:^(NSError *error) {
            if (error != nil) {
                PRINT_CONSOLE_LOG(@"error in deleting room")
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


#pragma mark - Custom Methods
- (void)setEditing:(BOOL)editing animated:(BOOL)animated { // Updates the appearance of the Edit|Done button item as necessary. Clients who override it must call super first.
    NSString *msg = [NSString stringWithFormat:@"%d",editing];
    PRINT_CONSOLE_LOG(msg);
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    self.navigationItem.rightBarButtonItem.enabled = !editing;
    
}

- (IBAction)addRooms:(id)sender {
    [self showAlert];
}


-(void)showAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Add Room",nil)]
                                                                             message:NSLocalizedString(@"Enter a room name.", @"Enter a room name.")
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Room name ";
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
        NSString *roomName = [newName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"added room string is:%@",roomName);
        if ([roomName length]>0) {
            [self addNewRoom:roomName];
            [self refreshTable];
        }
        NSLog(@"added room string :%@",[roomName length] > 0? roomName:@"Could not add");
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:addNewObject];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)refreshTable
{
    [self.tableView reloadData];
}
-(void)addNewRoom:(NSString*)roomName {
    __weak typeof(self) weakSelf = self;
    [self.home addRoomWithName:roomName completionHandler:^(HMRoom *room, NSError *error) {
        if (room == nil) {
            NSLog(@"Could not find the room");
            return ;
        }
        [weakSelf refreshTable];
        
        NSLog(@"successfully found room");
    }];
}
#pragma mark -- Add Zones.

@end
