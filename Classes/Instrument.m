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

@synthesize lastStep;
@synthesize recipe;
@synthesize instrumentSoftwareVersion;
@synthesize rtaSoftwareVersion;
@synthesize samples;

+(Instrument*) initFromRawData:(NSDictionary*)rawInstrumentData withName:(NSString*)instrName {
	Instrument *instrument = [[Instrument alloc] init];
	[instrument setFlowCellID:[rawInstrumentData objectForKey:@"flow_cell"]];
	[instrument setImagesTaken:[rawInstrumentData objectForKey:@"cycles_done"]];
	[instrument setImagesExpected:[rawInstrumentData objectForKey:@"cycles_estimated"]];
	[instrument setImagesTransferred:[rawInstrumentData objectForKey:@"transferred"]];
	[instrument setEstimatedReadCompletion:[rawInstrumentData objectForKey:@"estimated_completion"]];
	[instrument setInstrumentName:instrName];
	
	[instrument setLastStep:[rawInstrumentData objectForKey:@"last_step"]];
	[instrument setRecipe: [rawInstrumentData objectForKey:@"recipe"]];
	[instrument setInstrumentSoftwareVersion: [rawInstrumentData objectForKey:@"ins_software_version"]];
	[instrument setRtaSoftwareVersion:[rawInstrumentData objectForKey:@"rta_software_version"]];
	[instrument setSamples:[rawInstrumentData objectForKey:@"samples"]];
	
	return instrument;
}


-(NSString*) description {
	return [[NSString alloc] initWithFormat:@"Instrument %@", instrumentName];
}

@end
