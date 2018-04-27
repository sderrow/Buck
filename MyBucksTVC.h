//
//  MyBucksTVC.h
//  Buck
//
//  Created by Sean Derrow on 8/5/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface MyBucksTVC : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *context;
- (void)resetContext:(NSManagedObjectContext *)context;
@end
