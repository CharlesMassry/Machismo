//
//  ViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "ViewController.h"
#import "CardGame.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardGame *game;
@end

@implementation ViewController

-(CardGame *)game {
    if (!_game) {
        _game = [[CardGame alloc] initWithCardCount:self.cardButtons.count
                                          usingDeck:[self createDeck]];
    }
    
    return _game;
}

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

-(IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButton = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButton];
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
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

-(NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
