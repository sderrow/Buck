//
//  BuckPropertyCell.h
//  Buck
//
//  Created by Sean Derrow on 8/1/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuckPropertyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *propertyLabel;
@property (weak, nonatomic) IBOutlet UITextField *propertyTextField;

@end
