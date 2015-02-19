//
//  PlayingCardGameStatsViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/14/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "CardGameStatsViewController.h"

@interface CardGameStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@end

@implementation CardGameStatsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flips: %lu", self.flipCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
    self.gameCountLabel.text = [NSString stringWithFormat:@"Games: %lu", self.gameCount];
    self.totalScoreLabel.text = [NSString stringWithFormat:@"Total Score: %ld", (long)self.totalScore];
}

@end
