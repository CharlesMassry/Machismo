//
//  PlayingCardGameStatsViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/14/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "PlayingCardGameStatsViewController.h"

@interface PlayingCardGameStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation PlayingCardGameStatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flips: %lu", self.flipCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
