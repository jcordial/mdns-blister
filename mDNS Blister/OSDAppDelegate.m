//
//  OSDAppDelegate.m
//  mDNS Blister
//
//  Created by Jason Cordial on 11/29/12.
//  Copyright (c) 2012 Jason Cordial. All rights reserved.
//

#import "OSDAppDelegate.h"

@implementation OSDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	
	self.services = [[NSMutableArray alloc] init];
	self.table.dataSource = self;
	self.table.delegate = self;
	[self.table reloadData];
	self.table.rowHeight = 20;
	// Insert code here to initialize your applicationbest xml
	self.domainBrowser = [[NSNetServiceBrowser alloc] init];
    self.domainBrowser.delegate = self;
    [self.domainBrowser searchForServicesOfType: @"_services._dns-sd._udp."
	 inDomain:                @""];
	
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
	return self.services.count;
}
- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
	
    // get an existing cell with the MyView identifier if it exists
    NSTextField *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
	
    // There is no existing cell to reuse so we will create a new one
    if (result == nil) {
		
		// create the new NSTextField with a frame of the {0,0} with the width of the table
		// note that the height of the frame is not really relevant, the row-height will modify the height
		// the new text field is then returned as an autoreleased object
		result = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
		
		// the identifier of the NSTextField instance is set to MyView. This
		// allows it to be re-used
		result.identifier = @"MyView";
	}
	
	// result is now guaranteed to be valid, either as a re-used cell
	// or as a new cell, so set the stringValue of the cell to the
	// nameArray value at row
	result.stringValue = [[self.services objectAtIndex:row] name];
	
	// return the result.
	return result;
	
}
-(void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindDomain:(NSString *)domainString moreComing:(BOOL)moreComing{

	
}
-(void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing{
	[self.services addObject:aNetService];
	NSLog(aNetService.name);
	
	[self.table beginUpdates];
	
	[self.table insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.services.count-1] withAnimation:NSTableViewAnimationSlideRight];
	[self.table endUpdates];
}
-(void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing{
	NSUInteger index = [self.services indexOfObject:aNetService];
	[self.table beginUpdates];
	[self.services removeObject:aNetService];
	[self.table removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:index] withAnimation:NSTableViewAnimationEffectFade];
	[self.table endUpdates];
}
//-tableView

@end
