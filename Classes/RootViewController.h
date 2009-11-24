//
//  RootViewController.h
//  Sequencers
//
//  Created by Justin Lolofie on 11/20/09.
//  Copyright Washington University School of Medicine 2009. All rights reserved.
//

#import "Instrument.h"

@interface RootViewController : UITableViewController {
	
	NSMutableDictionary *rooms;
	NSMutableArray *roomList;
	NSMutableData *responseData;
	
	IBOutlet UITableView *equipmentTable;
}

@property (nonatomic, retain) IBOutlet UITableView *equipmentTable;

-(void)requestEquipmentInfo;
-(void)processJSONResponse:(NSString *)json;
-(Instrument *)instrumentForIndexPath:(NSIndexPath*) indexPath;

@end


