//
//  HomeListATableViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/19/15.
//  Copyright (c) 2015 Dh.Udhaykantth. All rights reserved.
//

#import "HomeListATableViewController.h"
#import "Constants.h"
#import "UITableView+CustomMessage.h"
#import "AccessoryListViewController.h"

@interface HomeListATableViewController ()
@property (nonatomic,readwrite) HMHome *myCurrentHome;
@property (nonatomic,strong) NSArray *homes;
@property (nonatomic,strong) HMService *service;
@property (nonatomic,strong) NSArray *allServices;
@end

@implementation HomeListATableViewController
#pragma mark -- view Life cycle
-(void)viewDidLoad
{ PRINT_CONSOLE_LOG(nil)
    [super viewDidLoad];
    
    self.homeManager = [[HMHomeManager alloc]init];;
    [self.homeManager setDelegate:self];
}
-(void)viewWillAppear:(BOOL)animated {
    PRINT_CONSOLE_LOG(nil)
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated {
    PRINT_CONSOLE_LOG(nil)

    [super viewDidAppear:animated];
}
-(void)dealloc {
}
#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PRINT_CONSOLE_LOG(nil)
    NSUInteger homeCount = self.homeManager.homes.count;
    [self.tableView hkd_addMessage:@"No Homes Configured" rowCount:homeCount];
        //return (homeCount == 0) ?1:homeCount;
    return homeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PRINT_CONSOLE_LOG(nil)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOME_LIST_A_IDENTIFIER_CELL forIndexPath:indexPath];
    cell.textLabel.text = [self.homeManager.homes[indexPath.row] name];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}             // Default is 1 if not implemented

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSUInteger homeCount = self.homeManager.homes.count;

    return (homeCount == 0) ?nil:@"Homes";
}    // fixed font style. use custom view (UILabel) if you want something different
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSUInteger homeCount = self.homeManager.homes.count;

    return (homeCount == 0) ?nil:@"List of homes Discovered";
}

#pragma  mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)
indexPath {
    PRINT_CONSOLE_LOG(nil)

}
#pragma mark -- HMHomeManager Delegates
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager {
      PRINT_CONSOLE_LOG(nil)
    self.homes = manager.homes;
    
     [ self.tableView reloadData];
}
#pragma  mark -- Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
PRINT_CONSOLE_LOG(nil)
    if ([segue.identifier isEqualToString:ACCESSORY_SERVICE_SEGUE]) {
        AccessoryListViewController *accessoryListViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        HMHome *home = [self homeForIndexPath:indexPath];
        [accessoryListViewController setHome:home];
        
    }
}
#pragma mark Custom methods
-(HMHome*)homeForIndexPath:(NSIndexPath*)indexPath {
    NSIndexPath *selectedIndextPath = self.tableView.indexPathForSelectedRow;
    HMHome *selectedHome= [self.homeManager.homes objectAtIndex:selectedIndextPath.row];
    self.myCurrentHome = selectedHome;
    return selectedHome;
    
}
/*-(HMService*)accessoryServiceForIndexPath:(NSIndexPath*)indexPath
{
   NSIndexPath *selectedService =   self.tableView.indexPathForSelectedRow;
    self.myCurrentHome = [self.homeManager.homes objectAtIndex:selectedService.row];
    
    
}
-(NSArray*)allServices {
    _allServices = self.myCurrentHome.accessories;
    return _allServices;
}
 */
@end
