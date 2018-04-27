//
//  BuckViewController.m
//  Buck
//
//  Created by Sean Derrow on 7/31/14.
//  Copyright (c) 2014 Buck, Inc. All rights reserved.
//

#import "BuckViewController.h"
#import "OpponentCDTVC.h"
#import "Pairing+Create.h"
#import "User+Create.h"

@interface BuckViewController ()
@property (weak, nonatomic) IBOutlet UILabel *propositionLabel;
@property (weak, nonatomic) IBOutlet UIButton *choice1Button;
@property (weak, nonatomic) IBOutlet UIButton *choice2Button;
@property (nonatomic) int selection;
@property (strong, nonatomic) UIColor *standardBackgroundColor;
@property (weak, nonatomic) IBOutlet UIButton *opponentButton;
@end

@implementation BuckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.standardBackgroundColor = self.choice1Button.backgroundColor;
	self.propositionLabel.text = self.buck.proposition;
    [self.choice1Button setTitle:self.buck.choice1 forState:UIControlStateNormal];
    [self.choice2Button setTitle:self.buck.choice2 forState:UIControlStateNormal];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
}

- (IBAction)touchChoiceButton:(UIButton *)sender
{
    if (self.selection == 1) {
        if ([sender isEqual:self.choice2Button]) {
            [sender setBackgroundColor:[UIColor greenColor]];
            [self.choice1Button setBackgroundColor:self.standardBackgroundColor];
            self.selection = 2;
        }
    } else if (self.selection == 2) {
        if ([sender isEqual:self.choice1Button]) {
            [sender setBackgroundColor:[UIColor greenColor]];
            [self.choice2Button setBackgroundColor:self.standardBackgroundColor];
            self.selection = 1;
        }
    } else {
        [sender setBackgroundColor:[UIColor greenColor]];
        if ([sender isEqual:self.choice1Button]) {
            self.selection = 1;
        } else self.selection = 2;
    }
}

- (void)setOpponent:(User *)opponent
{
    _opponent = opponent;
    [self.opponentButton setTitle:[NSString stringWithFormat:@"%@ %@",opponent.firstName, opponent.lastName] forState:UIControlStateNormal];
}

- (IBAction)touchBuckButton:(UIButton *)sender
{
    User *player = [User myUserID:self.context];
    
    [Pairing pairingWithBuck:self.buck players:[NSSet setWithObjects:player,self.opponent, nil] inManagedObjectContext:self.context];
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Opponent"]) {
        if ([segue.destinationViewController isKindOfClass:[OpponentCDTVC class]]) {
            OpponentCDTVC *osvc = (OpponentCDTVC *)segue.destinationViewController;
            osvc.buck = self.buck;
            osvc.context = self.context;
        }
    }
}

@end
