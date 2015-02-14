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

-(IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Playing Card Stats"]) {
        if ([segue.destinationViewController isKindOfClass:[PlayingCardGameStatsViewController class]]) {
            PlayingCardGameStatsViewController *playingCardGameStatsController = (PlayingCardGameStatsViewController *)segue.destinationViewController;
            playingCardGameStatsController.flipCount = self.game.flipCount;
        }
    }
}

@end
