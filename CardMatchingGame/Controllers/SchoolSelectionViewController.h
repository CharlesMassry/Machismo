//
//  SchoolSelectionViewController.h
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/20/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardGameViewController.h"

@interface SchoolSelectionViewController : UIViewController
@property(strong, nonatomic) NSString *school;
@property(strong, nonatomic) CardGameViewController *cardGameViewController;
@end
