//
//  ViewController.h
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardGame.h"

@interface CardGameViewController : UIViewController
@property (nonatomic) NSUInteger flipCount;
@property (strong, nonatomic) CardGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) NSUInteger newGameCounter;
@property (nonatomic) NSInteger totalScore;
@property (strong, nonatomic) NSString *school;
// protected
// for subclasses
-(Deck *)createDeck;
-(NSUInteger)numberOfCardsToCheck;

@end

