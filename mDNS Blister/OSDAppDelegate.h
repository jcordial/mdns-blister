//
//  OSDAppDelegate.h
//  mDNS Blister
//
//  Created by Jason Cordial on 11/29/12.
//  Copyright (c) 2012 Jason Cordial. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OSDAppDelegate : NSObject <NSApplicationDelegate ,NSTableViewDataSource,NSTableViewDelegate, NSNetServiceBrowserDelegate>{
}

@property (assign) IBOutlet NSWindow *window;
@property (readwrite) IBOutlet NSTableView* table;
@property (readwrite) NSMutableArray* services;
@property(readwrite) NSNetServiceBrowser* domainBrowser;
@end
