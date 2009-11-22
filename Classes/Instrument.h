//
//  Instrument.h
//  Sequencers
//
//  Created by Justin Lolofie on 11/21/09.
//  Copyright 2009 Washington University School of Medicine. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Instrument : NSObject {
	
	NSString *instrumentName;
	NSString *flowCellID;
	NSDate *estimatedReadCompletion;
	NSNumber *imagesTaken;
	NSNumber *imagesExpected;
	NSNumber *imagesTransferred;
}

@property (nonatomic, retain) NSString *instrumentName;
@property (nonatomic, retain) NSString *flowCellID;
@property (nonatomic, retain) NSDate *estimatedReadCompletion;
@property (nonatomic, retain) NSNumber *imagesTaken;
@property (nonatomic, retain) NSNumber *imagesExpected;
@property (nonatomic, retain) NSNumber *imagesTransferred;


@end
