//
//  Deck.h
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void) addCard:(Card *)card atTop:(BOOL)top;
-(void) addCard:(Card *)card;
-(Card *)drawRandomCard;

@end
