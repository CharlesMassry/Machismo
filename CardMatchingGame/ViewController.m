//
//  ViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Card *card;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (strong, nonatomic) PlayingCardDeck *deck;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deck = [[PlayingCardDeck alloc] init];
    self.card = [self.deck drawRandomCard];
    [self.cardButton setBackgroundColor:[UIColor blueColor]];
    [self.cardButton setTitle:@""
            forState:UIControlStateNormal];
    
}

-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if (sender.currentTitle.length) {
        [sender setBackgroundColor:[UIColor blueColor]];
        [sender setTitle:@""
                forState:UIControlStateNormal];
    } else {
        self.flipCount++;
        self.card = [self.deck drawRandomCard];
        [sender setBackgroundColor:[UIColor whiteColor]];
        [sender setTitle:[NSString stringWithFormat:@"%@", self.card.contents]
                forState:UIControlStateNormal];
    }
}

@end
