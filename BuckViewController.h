//
//  BuckViewController.h
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Buck.h"
#import "User.h"

@interface BuckViewController : UIViewController
@property (strong, nonatomic) Buck *buck;
@property (strong, nonatomic) User *opponent;
@property (strong, nonatomic) NSManagedObjectContext *context;
@end
