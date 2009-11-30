//
//  SequencerDetailViewController.m
//  Sequencers
//
//  Created by Ben Oberkfell on 11/23/09.
//  Copyright 2009 Washington University School of Medicine. All rights reserved.
//

#import "SequencerDetailViewController.h"


@implementation SequencerDetailViewController


@synthesize instrument;

-(id)initWithInstrument:(Instrument *)instr  {
	[super init];
	self.instrument = instr;
	return self;
}

-(IBAction)triggerMessage:(id) sender {
	UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Foo" message: @"Fooo" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
	[someError show];
	[someError release];	
}

-(IBAction)samplesButtonClicked:(id)sender {

	// TODO: use label instead of string
	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Samples"
												   message:@"stuff"
												  delegate:self
										 cancelButtonTitle:@"Cancel"
										   otherButtonTitles:@"Ok"];
	[alert show];
	[alert release];
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
	
	[flowCellID setText:instrument.flowCellID];
	
	float progress = [instrument.imagesTaken floatValue] / [instrument.imagesExpected floatValue];
	
	NSString *progressText = [[[NSString alloc] initWithFormat:@"%@/%@", instrument.imagesTaken, instrument.imagesExpected] autorelease];
		
	[cycleProgress setText:progressText];
	[cycleProgressBar setProgress:progress];
	
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
