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
    
    NSUInteger otherCardsCount = otherCards.count;
    
    int colorPoints = [self checkCardForSameFlag:allColorMatched
                                andDifferentFlag:allDifferentColor
                              withOtherCardCount:otherCardsCount];
    
    int symbolPoints = [self checkCardForSameFlag:allSymbolMatched
                                andDifferentFlag:allDifferentSymbol
                               withOtherCardCount:otherCardsCount];
    
    int shadingPoints = [self checkCardForSameFlag:allShadingMatched
                                  andDifferentFlag:allDifferentShading
                                withOtherCardCount:otherCardsCount];
    
    int numberPoints = [self checkCardForSameFlag:allNumberMatched
                                 andDifferentFlag:allDifferentNumber
                               withOtherCardCount:otherCardsCount];
    
    int totalPoints =  colorPoints + symbolPoints + shadingPoints + numberPoints;

    
    if ((colorPoints == 0 || symbolPoints == 0 || shadingPoints == 0 || numberPoints == 0) || (totalPoints % 4 != 0)) {
        return 0;
    }
    return totalPoints;
}

-(int)checkCardForSameFlag:(BOOL)allSame andDifferentFlag:(int)allDifferent withOtherCardCount:(NSUInteger)otherCardsCount {

    if (allSame) {
        return 4;
    } else if (allDifferent == (otherCardsCount + 1)) {
        return 1;
    } else {
        return 0;
    }

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
