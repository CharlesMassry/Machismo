//
//  PlayingCardDeck.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck
-(instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] initWithRank:rank suit:suit];
                [self addCard:card];
            }
        }
    }
    
    return self;
}
@end
