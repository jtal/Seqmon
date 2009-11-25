//
//  PushHelper.m
//  Sequencers
//
//  Created by Ben Oberkfell on 11/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PushHelper.h"
#import "Device.h"

@implementation PushHelper

@synthesize token;

-(PushHelper*)initWithTokenData:(NSData*)tok {
	
	[super init];
	
	self.token = [[[tok description] 
				 stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] 
				stringByReplacingOccurrencesOfString:@" " withString:@""];

	NSLog(@"Got a token.  And off we go.  %@", token);
	
	return self;
}

-(void)registerDevice {

	Device* dev = [[Device alloc] initWithToken:token];
	[dev saveRemote];
	[dev release];
}


@end

