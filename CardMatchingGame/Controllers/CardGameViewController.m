//
//  ViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.

#import "CardGameViewController.h"
#import "CardGameStatsViewController.h"
#import "SchoolSelectionViewController.h"
#import "CardGame.h"
#import "SetCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *scoreLabel;
@end

@implementation CardGameViewController

-(CardGame *)game {
    if (!_game) {
        _game = [[CardGame alloc] initWithCardCount:self.cardButtons.count
                                          usingDeck:[self createDeck]
                                    andCardsToCount:[self numberOfCardsToCheck]];
    }
    
    return _game;
}

-(Deck *)createDeck { // abstract
    return nil;
}

-(NSUInteger)numberOfCardsToCheck { // abstract
    return 0;
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

-(void)viewDidLoad {
    NSUserDefaults *schoolChoice = [NSUserDefaults standardUserDefaults];
    self.school = [schoolChoice stringForKey:@"school"];
    [super viewDidLoad];
    [self updateUI];
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
        
        [cardButton setAttributedTitle:[self titleForCard:card]
                              forState:UIControlStateNormal];
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.title = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (IBAction)touchForNewGameButton:(UIButton *)sender {
    self.game = nil;
    self.game = [[CardGame alloc] initWithCardCount:self.cardButtons.count
                                          usingDeck:[self createDeck]
                                    andCardsToCount:self.game.numberOfCardsToCheck];
    self.flipCount = 0;
    self.newGameCounter++;
    [self updateUI];
}

-(NSAttributedString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : [[NSAttributedString alloc] initWithString:@""];
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : self.school];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Card Stats"]) {
        if ([segue.destinationViewController isKindOfClass:[CardGameStatsViewController class]]) {
            
            CardGameStatsViewController *playingCardGameStatsController = (CardGameStatsViewController *)segue.destinationViewController;
            playingCardGameStatsController.flipCount = self.game.flipCount;
            playingCardGameStatsController.score = self.game.score;
            playingCardGameStatsController.gameCount = self.newGameCounter;
            playingCardGameStatsController.totalScore = self.totalScore;
        }
    } else if ([segue.identifier isEqualToString:@"School Change"]) {
        if ([segue.destinationViewController isKindOfClass:[SchoolSelectionViewController class]]) {
            SchoolSelectionViewController *schoolSelectionViewController = (SchoolSelectionViewController *)segue.destinationViewController;
            schoolSelectionViewController.cardGameViewController = self;
        }
    }
}

@end
