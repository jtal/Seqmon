//
//  PushHelper.h
//  Sequencers
//
//  Created by Ben Oberkfell on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PushHelper : NSObject {
	NSString *token;
}

+(PushHelper*)pushHelper;
-(void)setToken:(NSData*)tok;
-(void)registerDevice;
-(void)registerForFlowcellNotifications:(NSString*)flowcellName withStatus:(NSString*)notificationStatus;

@end
