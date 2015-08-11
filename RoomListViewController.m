//
//  RoomListViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/11/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "RoomListViewController.h"

@implementation RoomListViewController

#pragma mark - view LifeCycle 
-(void)viewDidLoad {
    
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
 }

- (void)dealloc {
 }
#pragma mark - Custom Methods
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
        NSString *trimmedName = [newName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"added room string is:%@",trimmedName);
        if ([trimmedName length]>0) {
           // [self addNewHome:trimmedName];
           // [self refreshTable];
        }
        NSLog(@"added room string :%@",[trimmedName length] > 0? trimmedName:@"Could not add");
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:addNewObject];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
