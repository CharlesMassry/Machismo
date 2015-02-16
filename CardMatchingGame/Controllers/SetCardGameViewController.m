//
//  SetCardGameViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/15/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "CardGameStatsViewController.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

-(Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

-(NSUInteger)numberOfCardsToCheck {
    return 3;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Set Card Stats"]) {
        if ([segue.destinationViewController isKindOfClass:[CardGameStatsViewController class]]) {
            
            CardGameStatsViewController *playingCardGameStatsController = (CardGameStatsViewController *)segue.destinationViewController;
            playingCardGameStatsController.flipCount = self.game.flipCount;
            playingCardGameStatsController.score = self.game.score;
            playingCardGameStatsController.gameCount = self.newGameCounter;
            playingCardGameStatsController.totalScore = self.totalScore;
        }
    }
}



@end
