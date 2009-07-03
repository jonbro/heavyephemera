//
//  CustomEventResponder.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "CustomEventResponder.h"


@implementation CustomEventResponder

@synthesize subviews;

-(id)init
{
	self = [super init];
	frame = CGRectMake(0, 0, 0, 0);
	subviews = [[NSMutableArray alloc] initWithCapacity:0];
	return self;
}
-(void)touchDown:(TouchEvent*)_tEvent
{}
-(void)touchUp:(TouchEvent*)_tEvent
{}
-(void)touchMoved:(TouchEvent*)_tEvent
{}
-(void)touchDoubleTap:(TouchEvent*)_tEvent
{}
-(bool)insideX:(float)x Y:(float)y
{
	return (x>frame.origin.x && y>frame.origin.y && x<frame.origin.x+frame.size.width && y<frame.origin.y+frame.size.height);
}
-(void)addSubview:(CustomEventResponder *)_view
{
	[subviews addObject:_view];
	[_view setSuperview:self];
}
-(void)setSuperview:(CustomEventResponder *)_superview
{
	[superview release];
	superview = [_superview retain];
}
@end
