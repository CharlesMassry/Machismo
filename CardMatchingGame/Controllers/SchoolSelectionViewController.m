//
//  SchoolSelectionViewController.m
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/20/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "SchoolSelectionViewController.h"

@interface SchoolSelectionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *calButton;
@property (weak, nonatomic) IBOutlet UIButton *rutgersButton;
@property (weak, nonatomic) IBOutlet UIButton *stanfordButton;
@end

@implementation SchoolSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSUserDefaults *schoolChoice = [NSUserDefaults standardUserDefaults];
    self.school = [self schoolForButton:sender];
    [schoolChoice setObject:self.school forKey:@"school"];
    [schoolChoice synchronize];
}


-(NSString *)schoolForButton:(UIButton *)sender {
    if (sender == self.calButton) {
        return @"cal";
    } else if (sender == self.rutgersButton) {
        return @"rutgers";
    } else {
        return @"stanford";
    }
    return nil;
}

@end
