//
//  Device.m
//  Sequencers
//
//  Created by Ben Oberkfell on 11/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Device.h"
#import "ObjectiveResource.h"

@implementation Device

@synthesize token;

-(Device*)initWithToken:(NSString *)tok {
	[super init];
	
	self.token = tok;
	return self;
	
}
	

@end
