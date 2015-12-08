//
//  PrefsController.m
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "PrefsController.h"

// check https://github.com/samsoffes/sskeychain for keychain access

@interface PrefsController ()

@end

@implementation PrefsController
- (IBAction)closeClicked:(id)sender {
    [NSApp endSheet:_prefsPanel];
    [_prefsPanel orderOut:sender];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
