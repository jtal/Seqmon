//
//  Room.m
//  Sequencers
//
//  Created by Justin Lolofie on 11/21/09.
//  Copyright 2009 Washington University School of Medicine. All rights reserved.
//

#import "Room.h"
#import "JSON.h"
#import "Instrument.h"


@implementation Room

@synthesize Instruments;
@synthesize roomNumber;
@synthesize instrumentList;

-(NSString *)description {
	
	return [[NSString alloc] initWithFormat:@"Room %@ with %d instruments",roomNumber, [instrumentList count]];
}

+(NSMutableArray *)roomListForJSON:(NSString*)jsonString {
	
	NSDictionary * json = [jsonString JSONValue];
	
	NSMutableArray* roomList = [[NSMutableArray alloc] init];
		
	NSEnumerator *roomEnum = [json keyEnumerator];
	
	NSString *thisRoomNumber;
	
	while((thisRoomNumber = [roomEnum nextObject])) {
		
		Room *room = [[Room alloc] init];
		
		[room setRoomNumber:thisRoomNumber];
		
		NSDictionary *rawRoomData = [json objectForKey:thisRoomNumber];
		NSEnumerator *instrumentEnum = [rawRoomData keyEnumerator];
		
		// store instruments temporarily until putting it in the room object
		NSMutableDictionary *instruments = [[NSMutableDictionary alloc] init];
		NSMutableArray *instrumentList = [[NSMutableArray alloc] init];
		
		NSString *instrumentName = [[NSString alloc] init];
		while((instrumentName = [instrumentEnum nextObject])) {
			
			NSDictionary *rawInstrumentData = [[NSDictionary alloc] init];
			rawInstrumentData = [rawRoomData objectForKey:instrumentName];
			
			//NSLog(@"dump of data: %@",rawInstrumentData);
			
			NSNumberFormatter* numForm = [[[NSNumberFormatter alloc] init] autorelease];
			[numForm setFormatterBehavior:NSNumberFormatterBehavior10_4];
			
			Instrument* instrument = [Instrument initFromRawData:rawInstrumentData withName:instrumentName];
			[instrumentList addObject:instrument];
						
			[room setInstrumentList:instrumentList];

			[instruments setObject:instrument forKey:instrumentName];
		}
		
		[room setInstruments:instruments];
		//NSLog(@"parsed room: %@",room);
		
		
		
		[roomList addObject:room];
	}
	
	
	//NSLog(@"parsed equipment data");
	//NSLog(@"woooo %@", roomList);
	return roomList;
}

@end
