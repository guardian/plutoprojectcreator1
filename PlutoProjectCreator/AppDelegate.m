//
//  AppDelegate.m
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSPanel *prefsPanel;

@end

@implementation AppDelegate
- (IBAction) showPrefs:(id)sender {
    [NSApp beginSheet:_prefsPanel
        modalForWindow:_window
        modalDelegate:self
        didEndSelector:@selector(prefsDidEnd:returnCode:contextInfo:)
        contextInfo:nil
     ];
    
}

- (void)prefsDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    /*[NSApp endSheet:sheet];
    [sheet orderOut:sheet];*/
    NSLog(@"prefs panel closed");
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
