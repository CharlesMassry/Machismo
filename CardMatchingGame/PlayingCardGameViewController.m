//
//  PlayingCardGameViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/11/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
