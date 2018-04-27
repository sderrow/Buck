//
//  NewBuckViewController.m
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "NewBuckViewController.h"
#import "User+Create.h"
#import "Buck+Create.h"
#import "BuckPropertyCell.h"
#import "BuckDateCell.h"

@interface NewBuckViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *propertiesTableView;
@end

@implementation NewBuckViewController

- (IBAction)touchCreateBuckButton:(UIButton *)sender
{
    
    NSString *userID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    User *user = [User userWithUserID:userID firstName:nil lastName:nil inManagedObjectContext:self.context];
    
    NSArray *cells = self.propertiesTableView.visibleCells;
    
    BuckPropertyCell *prop = (BuckPropertyCell *)cells[0];
    BuckPropertyCell *c1 = (BuckPropertyCell *)cells[1];
    BuckPropertyCell *c2 = (BuckPropertyCell *)cells[2];
    BuckDateCell *exp = (BuckDateCell *)cells[3];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    [Buck newBuckwithProposition:prop.propertyTextField.text
                            host:user
                         choice1:c1.propertyTextField.text
                         choice2:c2.propertyTextField.text
                  expirationDate:exp.expirationDatePicker.date
          inManagedObjectContext:self.context];
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.propertiesTableView.delegate = self;
    self.propertiesTableView.dataSource = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = 0;
    switch (section) {
        case 0:
            numRows = 3;
            break;
        case 1:
            numRows = 1;
            break;
    }
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"New Buck Property";
        BuckPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSArray *titles = @[@"Proposal",@"Choice 1",@"Choice 2"];
        cell.propertyLabel.text = titles[indexPath.row];
        cell.propertyTextField.delegate = self;
        return cell;
    } else {
        static NSString *CellIdentifier = @"New Buck Date";
        BuckDateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.expirationDatePicker.minimumDate = [NSDate date];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 52;
    } else {
        return 159;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
