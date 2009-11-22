//
//  Room.h
//  Sequencers
//
//  Created by Justin Lolofie on 11/21/09.
//  Copyright 2009 Washington University School of Medicine. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Room : NSObject {

	NSString *roomNumber;
	NSMutableDictionary *Instruments;
}

@property (nonatomic, retain) NSMutableDictionary *Instruments;
@property (nonatomic, retain) NSString *roomNumber;

@end
