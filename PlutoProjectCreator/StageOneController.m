//
//  StageOneController.m
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "StageOneController.h"
#import "StageTwoController.h"
#import "VSGlobalMetadata.h"
#import "BrowserDelegate.h"
#import "AppDelegate.h"

@interface StageOneController ()

@end

@implementation StageOneController

- (id) init {
    self = [super init];
    NSLog(@"stageOneController: init");
    return self;
    
}

- (void) awakeFromNib {
    //NSLog(@"stageOnecontroller: awakeFromNib");

    NSArray *content = [[_appDelegate vsGlobalMetadata] groupContent:@"WorkingGroup"];
    NSLog(@"%@",content);
    /*NSMutableArray *r = [NSMutableArray array];
    for (NSDictionary *entry in content){
        [r addObject:[entry valueForKey:@"gnm_subgroup_displayname"]];
    }
    NSLog(@"%@",r);*/
    [self setCanContinue:TRUE];
    if(content==nil || [content count]==0){
        NSAlert *a = [[NSAlert alloc] init];
        [a setMessageText:@"Unable to get working groups list from Vidispine"];
        [a setInformativeText:@"Check your server and login details are correct in Preferences or contact the system administrator"];
        [a setIcon:[NSImage imageNamed:NSImageNameCaution]];
        /*[a beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse returnCode){
            exit(1);
        }];
         */
        [self setCanContinue:FALSE];
        [a runModal];
    }
    [_browserDelegate setWorkingGroups:content];
}
- (void)windowDidLoad {
    [super windowDidLoad];
    NSLog(@"stageOneController: windowDidLoad");
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void) nextClicked:(id)sender
{
   [_stageTwoController setWorkingGroup:[_browserDelegate selectedWorkingGroup:_browserWidget]];
    [_stageTwoController setCommission:[_browserDelegate selectedCommission:_browserWidget]];

    [[self window] orderOut:sender];
    [_stageTwoController showWindow:sender];
}
@end
