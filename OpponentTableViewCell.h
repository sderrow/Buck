//
//  OpponentTableViewCell.h
//  Buck
//
//  Created by Sean Derrow on 8/2/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface OpponentTableViewCell : UITableViewCell
@property (strong, nonatomic) User *opponent;
@end
