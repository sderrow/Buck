//
//  BucksCDTVC.h
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface BucksCDTVC : CoreDataTableViewController

@property (strong, nonatomic) NSManagedObjectContext *context;
- (void)resetContext:(NSManagedObjectContext *)context;

@end
