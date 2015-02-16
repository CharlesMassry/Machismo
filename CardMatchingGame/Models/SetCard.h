//
//  SetCard.h
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/15/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

-(instancetype)initWithColor:(NSString *)color symbol:(NSString *)symbol number:(NSUInteger)number andShading:(NSString *)shading;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validNumbers;

@end
