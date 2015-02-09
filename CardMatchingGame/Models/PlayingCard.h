//
//  PlayingCard.h
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+(NSArray *)validSuits;
+(NSUInteger)maxRank;
-(instancetype)initWithRank:(NSUInteger)rank suit:(NSString *)suit;
@end
