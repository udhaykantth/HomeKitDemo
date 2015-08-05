//
//  AddHomeViewController.m
//  HomeKitDemo
//
//  Created by udhaykanthd on 8/5/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "AddHomeViewController.h"
#import "Constants.h"

@interface AddHomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *homeNameTxtField;
 

@end

@implementation AddHomeViewController

- (void)viewDidLoad {
    PRINT_CONSOLE_LOG(nil)
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    PRINT_CONSOLE_LOG(nil)
   if ([self.delegate respondsToSelector:@selector(addHomeViewControllerDidCancel:)]) {
        
    [self.delegate addHomeViewControllerDidCancel:self];
   }
}

- (IBAction)done:(id)sender {
    PRINT_CONSOLE_LOG(nil)
   if ([self.delegate respondsToSelector:@selector(addHomeViewControllerDidSave:)]) {
       if ([self.homeNameTxtField.text length ] == 0) {
           return;

       }
       self.homeText = self.homeNameTxtField.text;

       //[self.homeManager addHomeWithName:self.homeText completionHandler:nil];
       [self.delegate addHomeViewControllerDidSave:self];

      
   }
}
@end
