//
//  PushHelper.m
//  Sequencers
//
//  Created by Ben Oberkfell on 11/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PushHelper.h"
#import "Device.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

@implementation PushHelper

@synthesize token;

static PushHelper *sharedInstance = nil;

#pragma mark -
#pragma mark class instance methods

#pragma mark -
#pragma mark Singleton methods

+ (PushHelper*)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
			sharedInstance = [[PushHelper alloc] init];
    }
    return sharedInstance;
}

+ (id)allocWithToken:(NSData *)tok {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[PushHelper alloc] init];
			
			sharedInstance.token = [[[tok description] 
								stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] 
							   stringByReplacingOccurrencesOfString:@" " withString:@""];
			
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

-(void)registerDevice {
	
	//Device* dev = [[Device alloc] initWithToken:token];
	//[dev saveRemote];
	//[dev release];
	
	NSURL *url = [NSURL URLWithString:@"http://192.168.2.121:3000/devices/register_device.js"];
	ASIFormDataRequest *request =  [ASIFormDataRequest requestWithURL:url];
	
	//NSLog("Setting token ... %@", [self token]);
	
	//[request setPostValue:[self token] forKey:@"token"];
	//[request setDelegate:self];
	//[request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request {
	NSString *responseString = [request responseString];
	NSLog(@"RESPONSE IS %@", responseString);
}

-(void)requestFailed:(ASIHTTPRequest *)request {
	NSError *error = [request error];
	NSLog(@"Failed - %@", error);
}


- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

@end
/*
+(void)setDeviceToken:(NSData *)tok {
	
	NSString* token = [[[tok description] 
			  stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] 
			 stringByReplacingOccurrencesOfString:@" " withString:@""];
}
*/


@end

