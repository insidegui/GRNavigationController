//
//  COMainWindowController.m
//  Countries (demo app)
//
//  Created by Guilherme Rambo on 20/05/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "COMainWindowController.h"

@interface COMainWindowController ()

@end

@implementation COMainWindowController

- (id)init
{
    return [super initWithWindowNibName:NSStringFromClass([self class])];
}

- (void)showWindow:(id)sender
{
    [self.window center];
    [super showWindow:sender];
}

@end
