//
//  OpponentCDTVC.h
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Buck.h"
#import "CoreDataTableViewController.h"

@interface OpponentCDTVC : CoreDataTableViewController
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) Buck *buck;
@end
