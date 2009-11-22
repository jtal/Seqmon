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


@implementation RootViewController

@synthesize equipmentTable;

- (void)requestEquipmentInfo {

	responseData = [[NSMutableData data] retain];
	// @"http://www.kivasti.com/equipment.json.txt"
	// @"http://localhost/~jlolofie/equipment.json.txt"
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
	
	[self parseJSONValue:[responseString JSONValue]];
	[equipmentTable reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"connection failed: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	NSLog(@"closing connection");
}

-(void)parseJSONValue:(NSDictionary *)json {
	
	NSEnumerator *roomEnum = [json keyEnumerator];
	NSString *roomNumber = [[NSString alloc] init];
	
	while((roomNumber = [roomEnum nextObject])) {
		
		Room *room = [[Room alloc] init];
		[room setRoomNumber:roomNumber];

		NSDictionary *rawRoomData = [json objectForKey:roomNumber];
		NSEnumerator *instrumentEnum = [rawRoomData keyEnumerator];

		// store instruments temporarily until putting it in the room object
		NSMutableDictionary *instruments = [[NSMutableDictionary alloc] init];

		NSString *instrumentName = [[NSString alloc] init];
		while((instrumentName = [instrumentEnum nextObject])) {
			
			NSDictionary *rawInstrumentData = [[NSDictionary alloc] init];
			rawInstrumentData = [rawRoomData objectForKey:instrumentName];
			
			Instrument *instrument = [[Instrument alloc] init];
			[instrument setFlowCellID:[rawInstrumentData objectForKey:@"flow_cell"]];
			[instrument setImagesTaken:[rawInstrumentData objectForKey:@"imaged1"]];
			[instrument setImagesExpected:[rawInstrumentData objectForKey:@"imaged2"]];
			[instrument setImagesTransferred:[rawInstrumentData objectForKey:@"transferred"]];
			[instrument setEstimatedReadCompletion:[rawInstrumentData objectForKey:@"date"]];
		
			[instruments setObject:instrument forKey:instrumentName];
		}
		
		[room setInstruments:instruments];
		NSLog(@"parsed room: %@",room);
		[rooms setObject:room forKey:roomNumber];
	}

	NSLog(@"parsed equipment data");
}


- (void)viewDidLoad {
    
	[super viewDidLoad];
	
	[self setTitle:@"GC Sequencers"];
	
	rooms = [[NSMutableDictionary alloc] init];
	[self requestEquipmentInfo];
	
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[rooms allKeys] count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString *roomNumber = [[rooms allKeys] objectAtIndex:section];
    Room *room = [rooms objectForKey:roomNumber];
	return [[room Instruments] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *roomNumber = [[rooms allKeys] objectAtIndex:section];
	return [[NSString alloc] initWithFormat:@"Room %@",roomNumber];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSString *roomNumber = [[rooms allKeys] objectAtIndex:[indexPath section]];
	Room *room = [rooms objectForKey:roomNumber];
	
	NSMutableDictionary *instruments = [room Instruments];
	NSArray *instrumentNames = [instruments allKeys];
	
	Instrument *instrument = [instruments objectForKey:[instrumentNames objectAtIndex:[indexPath row]]];
	[[cell textLabel] setText:[instrument flowCellID]];

    return cell;
}



/*
// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
}
*/


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

