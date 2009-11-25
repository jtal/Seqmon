//
//  PushHelper.h
//  Sequencers
//
//  Created by Ben Oberkfell on 11/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PushHelper : NSObject {

	NSString *token;
}


@property (nonatomic, retain) NSString* token;

-(PushHelper*)initWithTokenData:(NSData*)tok;
-(void)registerDevice;

@end
