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
@property (nonatomic, strong)NSMutableArray *cards; // total cards in game
@end

@implementation CardGame
-(NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSUInteger)flipCount {
    if (!_flipCount) _flipCount = 0;
    return _flipCount;
}

-(NSMutableArray *)cardsToCheck {
    if (!_cardsToCheck) _cardsToCheck = [[NSMutableArray alloc] init];
    return _cardsToCheck;
}

-(instancetype)initWithCardCount:(NSUInteger)cardCount
                       usingDeck:(Deck *)deck
                 andCardsToCount:(NSUInteger)cardsToCount {
    self = [super init];
    
    if (self) {
        self.numberOfCardsToCheck = cardsToCount;
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

-(void)chooseCardAtIndex:(NSUInteger)index {
    self.scoreForTouch = 0;
    Card *card = [self cardAtIndex:index];
    self.flipCount++;
    if ([self cardIsNotSelected:card]) {
        [self.cardsToCheck addObject:card];
        self.scoreForTouch -= COST_TO_CHOOSE;
        self.score -= COST_TO_CHOOSE;
        if ([self rightNumberOfCardsToCheck]) {
            card.chosen = YES;
        } else {
            if (!card.isMatched) {
                if (card.isChosen) {
                    [self.cardsToCheck removeObject:card];
                    card.chosen = NO;
                } else {
                    BOOL noneMatched = NO;
                    for (Card *otherCard in self.cardsToCheck) {
                        if ([self cardIsChosenAndNotMatched:otherCard]) {
                            int matchScore = [card match:self.cardsToCheck];
                            if (matchScore) {
                                self.scoreForTouch += matchScore * MATCH_BONUS;
                                self.score += matchScore * MATCH_BONUS;
                                card.matched = YES;
                                otherCard.matched = YES;
                            } else {
                                self.scoreForTouch -= MISMATCH_PENALTY;
                                self.score -= MISMATCH_PENALTY;
                                noneMatched = YES;
                            }
                            break;
                        }
                    }
                    [self checkAllCardsIfMatched:noneMatched];
                }
            }
            [self.cardsToCheck removeAllObjects];
        }
    } else {
        card.chosen = NO;
        [self.cardsToCheck removeObject:card];
    }
}

-(void)checkAllCardsIfMatched:(BOOL)noneMatched {
    if (noneMatched) {
        [self.cardsToCheck makeObjectsPerformSelector:@selector(doNotMatchAndDoNotChoose)];
    } else {
        [self.cardsToCheck makeObjectsPerformSelector:@selector(matchAndChoose)];
    }
}

-(BOOL)rightNumberOfCardsToCheck {
    return self.cardsToCheck.count < self.numberOfCardsToCheck;
}

-(BOOL)cardIsNotSelected:(Card *)card {
    return ![self.cardsToCheck containsObject:card];
}

-(BOOL)cardIsChosenAndNotMatched:(Card *)card {
    return card.isChosen && !card.isMatched;
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (self.cards.count > 0) ? self.cards[index] : nil;
}
@end
