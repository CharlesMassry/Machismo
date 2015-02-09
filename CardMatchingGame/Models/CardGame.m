//
//  CardGame.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "CardGame.h"

@interface CardGame ()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; // cards in total game
@property (nonatomic, strong)NSMutableArray *cardsToCheck;
@end

@implementation CardGame
-(NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray *)cardsToCheck {
    if (!_cardsToCheck) _cardsToCheck = [[NSMutableArray alloc] init];
    return _cardsToCheck;
}

-(instancetype)initWithCardCount:(NSUInteger)cardCount
                     usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self.cards[i] = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int CARDS_TO_CHECK = 3;

-(void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (![self.cardsToCheck containsObject:card]) { // check if the card has been selected
        self.score -= COST_TO_CHOOSE; // calculate score
        if (self.cardsToCheck.count < (CARDS_TO_CHECK - 1)) { // check if the cards to check the right number of cards
            [self.cardsToCheck addObject:card]; // if not add the card to the cards to check collection
            card.chosen = YES; // mark it as chosen
        } else { // if there are the right number of cards to check
            if (!card.isMatched) { // if the card has not been matched yet
                if (card.isChosen) { // if the card is chosen
                    [self.cardsToCheck removeObject:card]; // remove it from the cards to check
                    card.chosen = NO; // set it to not chosen
                } else { // if it is chosen...
                    
                    BOOL noneMatched = NO;
                    for (Card *otherCard in self.cardsToCheck) { // iterate through the cards to check collection
                        
                        if (otherCard.isChosen && !otherCard.isMatched) { // if the current card is chosen and not matched
                            int matchScore = [card match:self.cardsToCheck]; // determine the score for this possible match
                            // needs to revert all if they dont all match
                            if (matchScore) { // if it came back with a score
                                self.score += matchScore * MATCH_BONUS; // calculate the current game score
                                card.matched = YES;  // set the card to be matched
                                otherCard.matched = YES; // set the other card to be matched
                                // need to set all cards
                            } else {
                                self.score -= MISMATCH_PENALTY; // calculate score
                                noneMatched = YES;
                            }
                            break; // break out of iteration
                        }
                    }
                    
                    if (noneMatched) {
                        for (Card *otherCard in self.cardsToCheck) {
                            otherCard.matched = NO;
                            otherCard.chosen = NO;
                        }
                        card.matched = NO;
                    } else {
                        for (Card *otherCard in self.cardsToCheck) {
                            otherCard.matched = YES;
                            otherCard.chosen = YES;
                        }
                        card.chosen = YES; // card is chosen
                        card.matched = YES;
                    }
                }
            }
            [self.cardsToCheck removeAllObjects];
        }
    } else {
        card.chosen = NO;
        [self.cardsToCheck removeObject:card];
    }
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (self.cards.count > 0) ? self.cards[index] : nil;
}
@end
