//
//  SetCard.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/15/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards {
    NSMutableArray *otherCardsToCheck = [[NSMutableArray alloc] initWithArray:otherCards];
    [otherCardsToCheck removeObjectAtIndex:[otherCardsToCheck indexOfObject:self]];
    int score = 0;
    BOOL allColorMatched    = YES,
        allSymbolMatched    = YES,
        allShadingMatched   = YES,
        allNumberMatched    = YES;
    int allDifferentColor   = 0,
        allDifferentSymbol  = 0,
        allDifferentShading = 0,
        allDifferentNumber  = 0;
    NSLog(@"self: %@", self.contents);
    for (SetCard *otherCard in otherCardsToCheck) {
        NSLog(@"%@", otherCard.contents);
        if ([self differentColor:otherCard]) {
            allColorMatched = NO;
            allDifferentColor++;
        }
        if ([self differentSymbol:otherCard]) {
            allSymbolMatched = NO;
            allDifferentSymbol++;
        }
        if ([self differentShading:otherCard]) {
            allShadingMatched = NO;
            allDifferentShading++;
        }
        if ([self differentNumber:otherCard]) {
            allNumberMatched = NO;
            allDifferentNumber++;
        }
    }
    
    NSLog(@"allDifferentColor: %d", allDifferentColor);
    NSLog(@"allDifferentSymbol: %d", allDifferentSymbol);
    NSLog(@"allDifferentShading: %d", allDifferentShading);
    NSLog(@"allDifferentNumber: %d", allDifferentNumber);
    
    if (allColorMatched) {
        score += 4;
    } else if (allDifferentColor == otherCards.count) {
        score++;
    } else {
        return 0;
    }
    
    if (allSymbolMatched) {
        score += 4;
    } else if (allDifferentSymbol == otherCards.count) {
        score ++;
    } else {
        return 0;
    }
    
    if (allShadingMatched) {
        score += 4;
    } else if (allDifferentShading == otherCards.count) {
        score ++;
    } else {
        return 0;
    }
    
    if (allDifferentNumber) {
        score += 4;
    } else if (allDifferentNumber == otherCards.count) {
        score++;
    } else {
        return 0;
    }
    
    return score;
}

-(instancetype)initWithColor:(NSString *)color symbol:(NSString *)symbol number:(NSUInteger)number andShading:(NSString *)shading {
    self = [super init];
    
    if (self) {
        [self setNumber:number];
        [self setColor:color];
        [self setSymbol:symbol];
        [self setShading:shading];
    }
    
    return self;
}

-(NSString *)contents {
    return [NSString stringWithFormat:@"%@ %@ %@ %lu", self.shading, self.color, self.symbol, self.number];
}

-(BOOL)differentColor:(SetCard *)otherCard {
    return [self.color isEqualToString:otherCard.color];
}

-(BOOL)differentSymbol:(SetCard *)otherCard {
    return [self.symbol isEqualToString:otherCard.symbol];
}

-(BOOL)differentShading:(SetCard *)otherCard {
    return [self.shading isEqualToString:otherCard.shading];
}

-(BOOL)differentNumber:(SetCard *)otherCard {
    return self.number == otherCard.number;
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *)validSymbols
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"open", @"striped"];
}

+ (NSArray *)validNumbers {
    return @[@1, @2, @3];
}

@end
