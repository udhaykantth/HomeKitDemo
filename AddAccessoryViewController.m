//
//  AddAccessoryViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/14/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "AddAccessoryViewController.h"
#import "Constants.h"
#import <HomeKit/HomeKit.h>

@interface AddAccessoryViewController()
@property (weak, nonatomic) IBOutlet UITableView *accessoryTableView;
@property(nonatomic,strong) HMAccessory *hmAccessory;


@end

@implementation AddAccessoryViewController

#pragma mark - viewController Methods
- (void)viewDidLoad {
    PRINT_CONSOLE_LOG(nil)
    [super viewDidLoad];
    self.accessoryTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;

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
#pragma mark -- AddAccessoryViewControllerDelegate
- (IBAction)cancel:(id)sender {
    PRINT_CONSOLE_LOG(nil)
    if ([self.delegate respondsToSelector:@selector(AddAccessoryViewControllerDidCancel:)]) {
        
        [self.delegate AddAccessoryViewControllerDidCancel:self];
    }
}
#pragma mark -- UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRINT_CONSOLE_LOG(nil)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADD_ACCESSORY_IDENTIFIER_CELL forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = @"searching...";//[self.home.rooms [indexPath.row]name];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
return @"select accessory";
}
#pragma mark -- UITableView Delegates


@end
