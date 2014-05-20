//
//  COAppDelegate.m
//  Countries (demo app)
//
//  Created by Guilherme Rambo on 20/05/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "COAppDelegate.h"
#import "COMainWindowController.h"

@interface COAppDelegate ()

@property (strong) COMainWindowController *mainWC;

@end

@implementation COAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // load the main window controller and show it's window
    self.mainWC = [[COMainWindowController alloc] init];
    [self.mainWC showWindow:self];
}

@end
