//
//  Events.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 6/30/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchEvent.h"
#import "CustomEventResponder.h"
@protocol CustomEventResponder;


@interface Events : NSObject {

}
+(void)setFirstResponder:(CustomEventResponder*)button;
+(void)touchDown:(TouchEvent*)_tEvent;
+(bool)manageTouchDown:(TouchEvent *)_tEvent forButton:(CustomEventResponder *)_repsonder;
+(bool)manageDoubleTouchDown:(TouchEvent *)_tEvent forButton:(CustomEventResponder *)_repsonder;
+(void)touchUp:(TouchEvent*)_tEvent;
+(void)touchMoved:(TouchEvent*)_tEvent;
+(void)touchDoubleTap:(TouchEvent*)_tEvent;

@end

@protocol CustomEventResponder
-(bool)insideX:(float)x Y:(float)y;
@end
