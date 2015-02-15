//
//  PlayingCardGameViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/11/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardGameStatsViewController.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Playing Card Stats"]) {
        if ([segue.destinationViewController isKindOfClass:[PlayingCardGameStatsViewController class]]) {
            
            PlayingCardGameStatsViewController *playingCardGameStatsController = (PlayingCardGameStatsViewController *)segue.destinationViewController;
            playingCardGameStatsController.flipCount = self.game.flipCount;
            playingCardGameStatsController.score = self.game.score;
            playingCardGameStatsController.gameCount = self.newGameCounter;
            playingCardGameStatsController.totalScore = self.totalScore;
        }
    }
}

@end
