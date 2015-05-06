//
//  AppDelegate.h
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#ifndef __app_delegate_h
#define __app_delegate_h
#import "VSGlobalMetadata.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSPanel *prefsPanel;
@property (weak) IBOutlet NSWindow *stageTwoWindow;
@property (weak) IBOutlet NSPanel *progressWindow;
@property (retain,atomic) VSGlobalMetadata *vsGlobalMetadata;
- (IBAction)showProgress:(id)sender;
- (IBAction)endProgress:(id)sender;
@end
#endif