//
//  Device.h
//  Sequencers
//
//  Created by Ben Oberkfell on 11/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Device : NSObject {
	NSString *token;
}

@property (nonatomic, retain) NSString *token;

-(Device*)initWithToken:(NSString *)tok;

@end
