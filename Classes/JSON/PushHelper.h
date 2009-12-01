//
//  PushHelper.h
//  Sequencers
//
//  Created by Ben Oberkfell on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RootViewController;

@interface PushHelper : NSObject {
	NSString *token;
	NSMutableDictionary *subscribedFlowcells;
}

+(PushHelper*)pushHelper;
-(void)setToken:(NSData*)tok;
-(void)registerDevice;
-(NSString*)urlBase;
-(NSString*)token;
-(void)setFlowcellSubscriptions:(NSArray*)flowcellList;
-(BOOL)isSubscribedToFlowcell:(NSString*)flowcellId;

@end
