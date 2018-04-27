//
//  BuckViewCell.h
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuckViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postedDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hostImage;
@property (weak, nonatomic) IBOutlet UILabel *hostRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *propositionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likesButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsLabel;
@property (strong, nonatomic) NSNumber *buckID;
@end
