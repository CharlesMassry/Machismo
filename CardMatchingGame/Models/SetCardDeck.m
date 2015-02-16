//
//  SetCardDeck.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/15/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSNumber *number in [SetCard validNumbers]) {
                        SetCard *setCard = [[SetCard alloc] initWithColor:color
                                                                   symbol:symbol
                                                                   number:[number integerValue]
                                                               andShading:shading];
                        [self addCard:setCard];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
