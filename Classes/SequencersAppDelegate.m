//
//  SequencersAppDelegate.m
//  Sequencers
//
//  Created by Justin Lolofie on 11/20/09.
//  Copyright Washington University School of Medicine 2009. All rights reserved.
//

#import "SequencersAppDelegate.h"
#import "RootViewController.h"
#import "PushHelper.h"
#import "ObjectiveResourceConfig.h"


@implementation SequencersAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch   
	
	
	NSString *pushServer = [[NSString alloc] initWithString: @"http://gcseq-app.gen-comp.com:80"];
	[ObjectiveResourceConfig setSite:pushServer];
	NSLog(@"connecting to push server: %s",pushServer);
	[pushServer release];
	
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)];
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark Push Notifications
// Delegation methods
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    //const void *devTokenBytes = [devToken bytes];
    //self.registered = YES;
	
	PushHelper * helper = [[PushHelper alloc] initWithTokenData:devToken];
	[helper registerDevice];
	
	//NSLog(@"Our token: %@", devToken);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

@end

