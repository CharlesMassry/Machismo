//
//  SetCard.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/15/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "SetCard.h"
#import <UIKit/UIKit.h>

@implementation SetCard

- (NSString *)description
{
    return [NSString stringWithFormat:@"number: %lu \n color: %@ \n symbol: %@ \n shading: %@", self.number, self.color, self.symbol, self.shading];
}

#pragma mark - matching

-(int)match:(NSArray *)otherCards {
    NSMutableArray *otherCardsToCheck = [[NSMutableArray alloc] initWithArray:otherCards];
    [otherCardsToCheck removeObject:self];
    int score = 0;
    BOOL allColorMatched    = YES,
        allSymbolMatched    = YES,
        allShadingMatched   = YES,
        allNumberMatched    = YES;
    int allDifferentColor   = 0,
        allDifferentSymbol  = 0,
        allDifferentShading = 0,
        allDifferentNumber  = 0;
    for (SetCard *otherCard in otherCardsToCheck) {
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

#pragma mark - initialization

-(instancetype)initWithColor:(NSString *)color symbol:(NSString *)symbol number:(NSUInteger)number andShading:(NSString *)shading {
    self = [super init];
    
    if (self) {
        [self setNumber:number];
        [self setColor:color];
        [self setSymbol:symbol];
        [self setShading:shading];
        NSAttributedString *contentsOfCard = [self createContents];
        [self setContents:contentsOfCard];
    }
    
    return self;
}

-(NSAttributedString *)createContents {
    NSString *colorNamed = [_color stringByAppendingString:@"Color"];
    SEL colorSelector = NSSelectorFromString(colorNamed);
    UIColor *uiColor = [UIColor performSelector:colorSelector];
    NSDictionary *attributes = [self getShadingAttributesWithColor:uiColor andShading:_shading];

    NSString *symbolDisplay = [@"" stringByPaddingToLength:_number withString:_symbol startingAtIndex:0];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:symbolDisplay attributes:attributes];
    
    return attributedString;
}

-(NSDictionary *)getShadingAttributesWithColor:(UIColor *)color andShading:(NSString *)shading {
    if ([shading isEqualToString:@"solid"]) {
        return @{
                 NSStrokeWidthAttributeName : @-5,
                 NSForegroundColorAttributeName : color
                };
    } else if ([shading isEqualToString:@"striped"]) {
        return @{
                 NSStrokeWidthAttributeName : @-5,
                 NSStrokeColorAttributeName : color,
                 NSForegroundColorAttributeName : [color colorWithAlphaComponent:0.1]
                };
    } else if ([shading isEqualToString:@"open"]) {
        return @{
                 NSStrokeWidthAttributeName : @5,
                 NSForegroundColorAttributeName : color
                };
    }
    return nil;
}

#pragma mark - attributeEquality

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


#pragma mark - validAttributes
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
