//
//  MyBucksTVC.m
//  Buck
//
//  Created by Sean Derrow on 8/5/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "MyBucksTVC.h"
#import "User+Create.h"
#import "Pairing.h"
#import "BuckViewCell.h"
#import "Buck.h"
#import "BucksCDTVC.h"

@interface MyBucksTVC ()
@property (strong, nonatomic) NSMutableArray *pairingBucks;
@end

@implementation MyBucksTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:0.00188841 green:0.913046 blue:0.00292991 alpha:1];
    
}

- (NSMutableArray *)pairingBucks
{
    if (!_pairingBucks) {
        _pairingBucks = [[NSMutableArray alloc] init];
    }
    return _pairingBucks;
}

- (void)setContext:(NSManagedObjectContext *)context
{
    [self resetContext:context];
    
    UITabBarController *tbvc = self.tabBarController;
    NSArray *viewControllers = tbvc.viewControllers;
    NSArray *items = tbvc.tabBar.items;
    
    for (int i = 0; i < [viewControllers count]; i++) {
        UITabBarItem *item = (UITabBarItem *)items[i];
        if ([item.title isEqualToString:@"Buck Feed"]) {
            UINavigationController *nvc = (UINavigationController *)viewControllers[i];
            BucksCDTVC *vc = (BucksCDTVC *)nvc.viewControllers[0];
            [vc resetContext:context];
        }
    }
}

- (void)resetContext:(NSManagedObjectContext *)context
{
    _context = context;
    
    User *player = [User myUserID:self.context];
    
    NSFetchRequest *pairingRequest = [NSFetchRequest fetchRequestWithEntityName:@"Pairing"];
    pairingRequest.predicate = [NSPredicate predicateWithFormat:@"%@ IN players", player];
    
    NSError *error;
    NSArray *pairs = [self.context executeFetchRequest:pairingRequest error:&error];
    
    if (!pairs) {
        NSLog(@"error fetching pairs with user");
    } else {
        for (Pairing *pairing in pairs) {
            [self.pairingBucks addObject:pairing.buck];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.pairingBucks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Buck Cell";
    BuckViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Buck *buck = self.pairingBucks[indexPath.row];
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


@end
