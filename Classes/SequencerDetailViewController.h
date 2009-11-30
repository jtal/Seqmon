//
//  SequencerDetailViewController.h
//  Sequencers
//
//  Created by Ben Oberkfell on 11/23/09.
//  Copyright 2009 Washington University School of Medicine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instrument.h"


@interface SequencerDetailViewController : UIViewController {
	
	IBOutlet UILabel *cycleProgress;
	IBOutlet UIProgressView *cycleProgressBar;
	IBOutlet UILabel *expectedCompletionDate;
	IBOutlet UILabel *flowCellID;
	
	Instrument *instrument;
}

@property (nonatomic, retain) Instrument* instrument;

-(id)initWithInstrument:(Instrument *)instrument;
-(IBAction)triggerMessage:(id)sender;
-(IBAction)samplesButtonClicked:(id)sender;

@end
