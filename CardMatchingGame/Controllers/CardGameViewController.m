//
//  ViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.

#import "CardGameViewController.h"
#import "CardGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *scoreLabel;
@end

@implementation CardGameViewController

-(CardGame *)game {
    if (!_game) {
        _game = [[CardGame alloc] initWithCardCount:self.cardButtons.count
                                          usingDeck:[self createDeck]];
    }
    
    return _game;
}

-(Deck *)createDeck { // abstract
    return nil;
}

-(NSUInteger)newGameCounter {
    if (!_newGameCounter) _newGameCounter = 0;
    return _newGameCounter;
}

-(NSUInteger)flipCount {
    if (!_flipCount) _flipCount = 0;
    return _flipCount;
}

-(NSInteger)totalScore {
    if (!_totalScore) _totalScore = 0;
    return _totalScore;
}

-(IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.totalScore += self.game.scoreForTouch;
    [self updateUI];
}

-(void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.title = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

-(NSString *)titleForCard:(Card *)card {
    if (card.isChosen) {
        return card.contents;
    } else {
        return @"";
    }
}
- (IBAction)touchForNewGameButton:(UIButton *)sender {
    self.game = nil;
    self.game = [[CardGame alloc] initWithCardCount:self.cardButtons.count
                              usingDeck:[self createDeck]];
    self.flipCount = 0;
    self.newGameCounter++;
    [self updateUI];
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
