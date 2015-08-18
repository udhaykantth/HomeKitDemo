//
//  AddAccessoryViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/14/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "AddAccessoryViewController.h"
#import "Constants.h"

@interface AddAccessoryViewController()
@property (weak, nonatomic) IBOutlet UITableView *accessoryTableView;
@property(nonatomic,strong) HMAccessory *hmAccessory;
@property(nonatomic,strong) HMAccessoryBrowser *hmAccessoryBrowser;
@property(nonatomic,strong) NSArray *listedAccessories;
@property(nonatomic,strong) NSString* defaultAccessoryCellText;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation AddAccessoryViewController

#pragma mark - viewController Methods
- (void)viewDidLoad {
    PRINT_CONSOLE_LOG(nil)
    [super viewDidLoad];
    self.accessoryTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    [self setDefaultAccessoryCellText:DEFAULT_ACCESSORY_CELL_TEXT];
    self.hmAccessoryBrowser = [[HMAccessoryBrowser alloc ] init];
    [self.hmAccessoryBrowser setDelegate:self];
    [self startBrowser];

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
    [self stopBrowser];
}
#pragma mark -- AddAccessoryViewControllerDelegate
- (IBAction)cancel:(id)sender {
    PRINT_CONSOLE_LOG(nil)
    [self stopBrowser];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   NSUInteger rows = [self.listedAccessories count];
    if (rows == 0) {
        [self setDefaultAccessoryCellText:NO_FOUND_ACCESSORY_CELL_TEXT];
        return 1;

    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRINT_CONSOLE_LOG(nil)
    NSString *reUseIdentifier;
    NSUInteger listedAccessoriesCount = [self.listedAccessories count];
    HMAccessory* foundAccessory = self.listedAccessories[indexPath.row];
    if ( listedAccessoriesCount == 0) {
        reUseIdentifier = DEFAULT_ACCESSORY_CELL;
    }
    else
    {
        reUseIdentifier = ADD_ACCESSORY_IDENTIFIER_CELL;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseIdentifier forIndexPath:indexPath];
    
    if (listedAccessoriesCount == 0) {
        // Configure the cell...
        cell.textLabel.text = self.defaultAccessoryCellText;
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    else
    {
        cell.textLabel.text = [foundAccessory name];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return HEADER_SECTION_TITLE;
}

#pragma mark -- UITableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PRINT_CONSOLE_LOG(nil)
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self stopBrowser];
        // [self configureAccessory];

}
#pragma mark -- HMAccessoryBrowserDelegate
- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory {
    NSLog(@"didFindNewAccessory :%@,services:%@",accessory.name,[accessory.services description]);
    [self reloadTable];

}
- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory {
    PRINT_CONSOLE_LOG(nil)
    [self reloadTable];

}
#pragma mark -- custom HMAccessoryBrowser methods
-(void)startBrowser {
    [self.hmAccessoryBrowser startSearchingForNewAccessories];
    [self showActivityIndicator];

}
-(void) stopBrowser {
    [self.hmAccessoryBrowser stopSearchingForNewAccessories];
    [self hideActivityIndicator];

}
#pragma mark -- Custom methods
-(void) hideActivityIndicator {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];

}
-(void)showActivityIndicator {
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    

}
-(void)resetListedAccessories {
    self.listedAccessories = self.hmAccessoryBrowser.discoveredAccessories;
}
-(void)reloadTable {
    [self resetListedAccessories];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.accessoryTableView reloadData];
    });
}
-(void)configureAccessory {
    PRINT_CONSOLE_LOG(nil)
    [self performSegueWithIdentifier:ACCESSORY_SEGUE sender:self];

}


@end
