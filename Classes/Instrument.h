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
	
	NSString *recipe;
	NSString *lastStep;
	NSString *instrumentSoftwareVersion;
	NSString *rtaSoftwareVersion;
	NSArray *samples;
}

@property (nonatomic, retain) NSString *instrumentName;
@property (nonatomic, retain) NSString *flowCellID;
@property (nonatomic, retain) NSDate *estimatedReadCompletion;
@property (nonatomic, retain) NSNumber *imagesTaken;
@property (nonatomic, retain) NSNumber *imagesExpected;
@property (nonatomic, retain) NSNumber *imagesTransferred;

@property (nonatomic, retain) NSString *instrumentSoftwareVersion;
@property (nonatomic, retain) NSString *rtaSoftwareVersion;
@property (nonatomic, retain) NSString *recipe;
@property (nonatomic, retain) NSString *lastStep;
@property (nonatomic, retain) NSArray *samples;


+(Instrument*)initFromRawData:(NSDictionary*)rawInstrumentData withName:(NSString*)instrName;

@end
