//
//  Card.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score++;
        }
    }
    
    return score;
}

@end
