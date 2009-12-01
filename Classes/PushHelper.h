//
//  PushHelper.h
//  Sequencers
//
//  Created by Ben Oberkfell on 11/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;
@interface PushHelper : NSObject {

	NSString *token;
}

@property (retain, nonatomic) NSString * token;

+(PushHelper*)sharedInstance;
+ (id)allocWithToken:(NSData *)tok;


-(void)registerDevice;

-(void)requestFinished:(ASIHTTPRequest *)request;
-(void)requestFailed:(ASIHTTPRequest *)request;

@end
