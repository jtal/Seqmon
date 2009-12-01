//
//  RootViewController.m
//  Sequencers
//
//  Created by Justin Lolofie on 11/20/09.
//  Copyright Washington University School of Medicine 2009. All rights reserved.
//

#import "RootViewController.h"
#import "JSON.h"
#import "Instrument.h"
#import "Room.h"
#import "SequencerDetailViewController.h"
#include "PushHelper.h"
#include "ASIHTTPRequest.h"


@implementation RootViewController

@synthesize equipmentTable;

- (void)requestNotificationData {
	
	
	loadingView = [[UIView alloc] initWithFrame:[[self view] bounds]];
	[loadingView setBackgroundColor:[UIColor blackColor]];
	[loadingView setAlpha:0.5];
	UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[[self view] addSubview:loadingView];
	[loadingView addSubview:indicator];
	[indicator setFrame:CGRectMake ((320/2)-20, (480/2)-20, 40, 40)];
	[indicator startAnimating];
	
	PushHelper *helper = [PushHelper pushHelper];
	NSLog(@"Querying for notification data");
	
	
	NSString *urlStr = [[NSString alloc] initWithFormat:@"%@/flowcells/get_notification_data/%@", [helper urlBase], [helper token]];
	NSURL *url = [NSURL URLWithString:urlStr];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		
	[request setDelegate:self];
	[request startAsynchronous];
	
	//[self requestEquipmentInfo];
}

-(void)requestFinished:(ASIHTTPRequest*)request {
	NSString *jsonString = [request responseString];
	NSDictionary * json = [jsonString JSONValue];
	
	NSArray *fcSubs = [json objectForKey:@"flowcell_subscriptions"];
	PushHelper *helper = [PushHelper pushHelper];
	[helper setFlowcellSubscriptions:fcSubs];
	
	NSArray *fcNotified = [json objectForKey:@"unseen_notifications"];
	NSLog(@"USN is %@", fcNotified);
	[helper setFlowcellsNotified:fcNotified];
	
	[self requestEquipmentInfo];
}



- (void)gotNotificationData {
	[self requestEquipmentInfo];
}

- (void)requestEquipmentInfo {
	
	responseData = [[NSMutableData data] retain];
	// @"http://www.kivasti.com/equipment.json.txt"
	// @"http://localhost/~jlolofie/equipment.json.txt"
	// @"http://www.kivasti.com/e.json.txt"
	// @"http://gcseq-app.gen-comp.com/seq.txt"
	NSString *url = [[NSString alloc] initWithString:@"http://www.kivasti.com/equipment.json.txt"];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
		
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	NSLog(@"requesting equipment info");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
	NSLog(@"received response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];

	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"received data");
	
	[self processJSONResponse:responseString];
	
	[equipmentTable reloadData];
	[loadingView removeFromSuperview];
	NSLog(@"done...");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"connection failed: %@", error);
	[loadingView removeFromSuperview];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	NSLog(@"closing connection");
}

-(void)processJSONResponse:(NSString *)json {
	roomList = [Room roomListForJSON:json];
	
	NSEnumerator* enumerator = [roomList objectEnumerator];
	
	Room * room;
	while((room = [enumerator nextObject])) {
		[rooms setObject:room forKey:room.roomNumber];
	}
	
}


- (void)viewDidLoad {
    
	[super viewDidLoad];
	
	[self setTitle:@"Sequencers"];
	
	rooms = [[NSMutableDictionary alloc] init];
	[self requestNotificationData];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}

- (Instrument*)instrumentForIndexPath:(NSIndexPath *)indexPath {
	Room* ourRoom = [roomList objectAtIndex:[indexPath section]];
	return [ourRoom.instrumentList objectAtIndex:[indexPath row]];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[rooms allKeys] count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[roomList objectAtIndex:section] instrumentList] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[roomList objectAtIndex:section] roomNumber];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    	
	Instrument *instrument = [self instrumentForIndexPath:indexPath];
	[[cell textLabel] setText:[instrument instrumentName]];
	
	NSString *detailedText =[[NSString alloc] initWithFormat:@"Cycle %@/%@ (%@ transferred)",
							 [instrument imagesTaken], 
							 [instrument imagesExpected],
							 [instrument imagesTransferred]
							 ];

	[[cell detailTextLabel] setText:detailedText];
	[detailedText release];
	
	PushHelper *helper = [PushHelper pushHelper];
	if ([helper isNotifiedAboutFlowcell:instrument.flowCellID]) {
		cell.backgroundColor = [UIColor yellowColor];
	} else {
		cell.backgroundColor = [UIColor whiteColor];
	}

	
	return cell;
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
 
	Instrument *instrument = [self instrumentForIndexPath:indexPath];
	
	SequencerDetailViewController *svdc = [[SequencerDetailViewController alloc] initWithInstrument:instrument];
	[self.navigationController pushViewController:svdc animated:YES];
	[svdc setTitle:[instrument instrumentName]];
	[svdc release];
 
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

