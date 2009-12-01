//
//  PushHelper.m
//  Sequencers
//
//  Created by Ben Oberkfell on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PushHelper.h"
#import "ASIFormDataRequest.h";
#import "ASINetworkQueue.h";

@implementation PushHelper
static PushHelper *sharedPushHelper = nil;
static NSString * URL_BASE = @"http://cheesegrater.local:3000";

#pragma mark Token Registration


-(PushHelper*)init {
	NSString * tempToken = @"262f8925b0ed878c39c0886cb30ec32a504a21179245882447ff3a585dfda4ca";
	[super init];
	token = tempToken;
	
	return self;
}

-(void)setToken:(NSData*)tok {
	
	token = [[[tok description] 
				   stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] 
				   stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	[token retain];
}

-(NSString*)token {
	return token;
}

-(void)registerDevice {
	NSLog(@"Going to register...");
	
	NSString *urlStr = [[NSString alloc] initWithFormat:@"%@/devices/register_device", URL_BASE];
	NSURL *url = [NSURL URLWithString:urlStr];
	
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:token forKey:@"token"];
	[request setDelegate:self];
	[request startAsynchronous];
}

-(void)registerForFlowcellNotifications:(NSString*)flowcellName withStatus:(NSString*)notificationStatus {
	NSLog(@"Registering flowcell %@ with status %@ and token %@", flowcellName, notificationStatus, token);

	NSString *urlStr = [[NSString alloc] initWithFormat:@"%@/flowcells/register_flowcell_notify", URL_BASE];
	NSLog(@"URL IS %@", urlStr);
	NSURL *url = [NSURL URLWithString:urlStr];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	
	[request setPostValue:token forKey:@"token"];
	[request setPostValue:flowcellName forKey:@"flowcell"];
	[request setPostValue:notificationStatus forKey:@"status"];
	[request setDelegate:self];
	[request startAsynchronous];
}	


#pragma mark ASI Network Delegate
-(void)requestFinished:(ASIHTTPRequest *)request{
	NSLog(@"Success!");
}

-(void)requestFailed:(ASIHTTPRequest *)request{
	NSLog(@"Failed :(");
	
}


#pragma mark Singleton Specific

+(PushHelper*)pushHelper {
	if (sharedPushHelper == nil) {
        sharedPushHelper = [[super alloc] init];
    }
    return sharedPushHelper;	
}


-(id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end
