//
//  CardGame.h
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardGame : NSObject
-(instancetype) initWithCardCount:(NSUInteger)cardCount
                        usingDeck:(Deck *)deck
                  andCardsToCount:(NSUInteger) cardsToCount;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
@property(nonatomic) NSUInteger numberOfCardsToCheck;
@property(nonatomic, readonly)NSInteger score;
@property(nonatomic) NSUInteger flipCount;
@property(nonatomic) NSInteger scoreForTouch;
@property (nonatomic, strong)NSMutableArray *cardsToCheck;
@end
