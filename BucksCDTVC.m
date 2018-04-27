//
//  BucksCDTVC.m
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "BucksCDTVC.h"
#import "BuckDatabaseAvailability.h"
#import "Buck.h"
#import "BuckViewCell.h"
#import "User.h"
#import "BuckViewController.h"
#import "NewBuckViewController.h"
#import "MyBucksTVC.h"

@interface BucksCDTVC ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createBuckBarButtonItem;

@end

@implementation BucksCDTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:0.00188841 green:0.913046 blue:0.00292991 alpha:1];
    
    self.createBuckBarButtonItem.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserverForName:BuckDatabaseAvailabilityNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      self.context = note.userInfo[BuckDatabaseAvailabilityContext];
                                                      self.createBuckBarButtonItem.enabled = YES;
                                                  }];
}

- (void)setContext:(NSManagedObjectContext *)context
{
    [self resetContext:context];
    
    UITabBarController *tbvc = self.tabBarController;
    NSArray *viewControllers = tbvc.viewControllers;
    NSArray *items = tbvc.tabBar.items;
    
    for (int i = 0; i < [viewControllers count]; i++) {
        UITabBarItem *item = (UITabBarItem *)items[i];
        if ([item.title isEqualToString:@"My Bucks"]) {
            
            UINavigationController *nvc = (UINavigationController *)viewControllers[i];
            MyBucksTVC *vc = (MyBucksTVC *)nvc.viewControllers[0];
            [vc resetContext:context];
        }
    }
}

- (void)resetContext:(NSManagedObjectContext *)context
{
    _context = context;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Buck"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"expirationDate"
                                                              ascending:YES
                                                               selector:@selector(compare:)]];
    
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuckViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Buck Cell"];
    
    Buck *buck = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    cell.postedDateLabel.text = [dateFormatter stringFromDate:buck.postedDate];
    cell.expirationDateLabel.text = [NSString stringWithFormat:@"Expires %@",[dateFormatter stringFromDate:buck.expirationDate]];
    cell.propositionLabel.text = buck.proposition;
    cell.hostImage.image = [UIImage imageWithData:buck.host.thumbnail];
    cell.hostRatingLabel.text = [NSString stringWithFormat:@"%d/10", [buck.host.hostRating intValue]];
    cell.likesButton.titleLabel.text = [NSString stringWithFormat:@"%d Likes", [buck.likeCount intValue]];
    cell.commentsLabel.titleLabel.text = [NSString stringWithFormat:@"%d Comments", [buck.comments count]];
    cell.buckID = buck.buckID;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Buck Details"]) {
        if ([segue.destinationViewController isKindOfClass:[BuckViewController class]]) {
            if ([sender isKindOfClass:[BuckViewCell class]]) {
                BuckViewController *bvc = (BuckViewController *)segue.destinationViewController;
                NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
                Buck *buck = [self.fetchedResultsController objectAtIndexPath:indexPath];
                bvc.buck = buck;
                bvc.context = self.context;
            }
        }
    }
    else if ([segue.identifier isEqualToString:@"New Buck"]) {
        if ([segue.destinationViewController isKindOfClass:[NewBuckViewController class]]) {
            NewBuckViewController *nbvc = (NewBuckViewController *)segue.destinationViewController;
            nbvc.context = self.context;
        }
    }
}



@end
