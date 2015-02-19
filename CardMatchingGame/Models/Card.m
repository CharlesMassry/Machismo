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
        if ([card.contents.string isEqualToString:self.contents.string]) {
            score++;
        }
    }
    
    return score;
}

-(void)doNotMatchAndDoNotChoose {
    self.matched = NO;
    self.chosen = NO;
}

-(void)matchAndChoose {
    self.matched = YES;
    self.chosen = YES;
}

-(NSString *)description {
    return self.contents.string;
}

@end
