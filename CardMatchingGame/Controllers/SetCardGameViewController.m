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

@end
