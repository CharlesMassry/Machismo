//
//  Card.h
//  CardMatchingGame
//
//  Created by Charlie Massry on 2/1/15.
//
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int) match:(NSArray *)cards;
-(void) doNotMatchAndDoNotChoose;
-(void) matchAndChoose;
@end
