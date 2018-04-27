//
//  OpponentCDTVC.m
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "OpponentCDTVC.h"
#import "User.h"
#import "OpponentTableViewCell.h"
#import "BuckViewController.h"

@interface OpponentCDTVC ()
@property (weak, nonatomic) IBOutlet UIImageView *opponentImageView;

@end

@implementation OpponentCDTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", @"cecilUserID"];
    
    NSError *error;
    NSArray *matches = [self.context executeFetchRequest:request error:&error];
    
    if ([matches count]) {
        User *opponent = [matches firstObject];
        self.opponentImageView.image = [UIImage imageNamed:[opponent.firstName lowercaseString]];
    }
    
}

- (void)setContext:(NSManagedObjectContext *)context
{
    _context = context;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"userID != %@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"playerRating"
                                                              ascending:NO
                                                               selector:@selector(localizedStandardCompare:)]];
    
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Opponent Cell"];
    
    User *opponent = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", opponent.firstName, opponent.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%3.1f%%", 100*[opponent.playerRating floatValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Opponent Cell"];
    User *opponent = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    BuckViewController *parent = viewControllers[[viewControllers count] - 2];
    
    parent.opponent = opponent;
    
    [self.navigationController popViewControllerAnimated:TRUE];
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
