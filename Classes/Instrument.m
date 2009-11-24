//
//  Instrument.m
//  Sequencers
//
//  Created by Justin Lolofie on 11/21/09.
//  Copyright 2009 Washington University School of Medicine. All rights reserved.
//

#import "Instrument.h"


@implementation Instrument

@synthesize instrumentName;
@synthesize flowCellID;
@synthesize estimatedReadCompletion;
@synthesize imagesTaken;
@synthesize imagesExpected;
@synthesize imagesTransferred;

+(Instrument*) initFromRawData:(NSDictionary*)rawInstrumentData withName:(NSString*)instrName {
	Instrument *instrument = [[Instrument alloc] init];
	[instrument setFlowCellID:[rawInstrumentData objectForKey:@"flow_cell"]];
	[instrument setImagesTaken:[rawInstrumentData objectForKey:@"imaged1"]];
	[instrument setImagesExpected:[rawInstrumentData objectForKey:@"imaged2"]];
	[instrument setImagesTransferred:[rawInstrumentData objectForKey:@"tranferred"]];
	[instrument setEstimatedReadCompletion:[rawInstrumentData objectForKey:@"date"]];
	[instrument setInstrumentName:instrName];
	
	return instrument;
}


-(NSString*) description {
	return [[NSString alloc] initWithFormat:@"Instrument %@", instrumentName];
}

@end
