//
//  StageOneController.h
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#ifndef __stage_one_controller
#define __stage_one_controller

#import "BrowserDelegate.h"
#import "StageTwoController.h"
#import "AppDelegate.h"

@interface StageOneController : NSWindowController
- (IBAction)nextClicked:(id)sender;

@property (weak) IBOutlet BrowserDelegate *browserDelegate;
@property (weak) IBOutlet NSBrowser *browserWidget;
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet StageTwoController *stageTwoController;
@property (weak) IBOutlet AppDelegate *appDelegate;
@end

#endif
