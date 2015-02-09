//
//  Deck.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

-(NSMutableArray *) cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void) addCard:(Card *)card atTop:(BOOL)top {
    if (top) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

-(void) addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

-(Card *)drawRandomCard {
    Card *randomCard = nil;

    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}
@end
