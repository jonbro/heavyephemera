//
//  MoveInstruction.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "turtle.h"

@interface MoveInstruction : NSObject {
	NSNumber*			amount;
	NSMutableString*	direction;
}

@property (copy) NSNumber*			amount;
@property (copy) NSMutableString*	direction;

-(void)processTurtle:(id)_turtle;

@end