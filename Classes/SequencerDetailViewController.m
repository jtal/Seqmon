//
//  SequencerDetailViewController.m
//  Sequencers
//
//  Created by Ben Oberkfell on 11/23/09.
//  Copyright 2009 Washington University School of Medicine. All rights reserved.
//

#import "SequencerDetailViewController.h"
#import "PushHelper.h"


@implementation SequencerDetailViewController


@synthesize instrument;


-(id)initWithInstrument:(Instrument *)instr  {
	[super init];
	self.instrument = instr;
	return self;
}

-(IBAction)triggerMessage:(id) sender {
	
	PushHelper * helper = [PushHelper pushHelper];
	
	NSString *status = ([notificationSwitch isOn] ? @"on" : @"off");
	
	[helper registerForFlowcellNotifications:instrument.flowCellID withStatus:status];

	[status release];
}

-(IBAction)samplesButtonClicked:(id)sender {

	NSString *sampleStr = [[NSString alloc] initWithString:[[instrument samples] componentsJoinedByString:@"\n"]];
	NSLog(@"***Samples string: %@",sampleStr);
	
	UIAlertView *samplesAlert =[[UIAlertView alloc] initWithTitle:@"Samples" message:sampleStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[samplesAlert show];
	[samplesAlert autorelease]; 
	[sampleStr autorelease];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	PushHelper *helper = [PushHelper pushHelper];
	
	[flowCellID setText:instrument.flowCellID];
	[rtaSoftwareVersion setText:[instrument rtaSoftwareVersion]];
	[instrumentSoftwareVersion setText:[instrument instrumentSoftwareVersion]];
	[lastStep setText:[instrument lastStep]];
	[recipe setText:[instrument recipe]];
	
	float progress = [instrument.imagesTaken floatValue] / [instrument.imagesExpected floatValue];
	
	NSString *progressText = [[[NSString alloc] initWithFormat:@"%@/%@", instrument.imagesTaken, instrument.imagesExpected] autorelease];
		
	[cycleProgress setText:progressText];
	[cycleProgressBar setProgress:progress];
	
	[notificationSwitch setOn:[helper isSubscribedToFlowcell:instrument.flowCellID]];
	
	[expectedCompletionDate setText:[[instrument estimatedReadCompletion] description]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
