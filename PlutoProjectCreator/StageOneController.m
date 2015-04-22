//
//  StageOneController.m
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "StageOneController.h"
#import "VSGlobalMetadata.h"
#import "BrowserDelegate.h"

@interface StageOneController ()
@property (weak) IBOutlet BrowserDelegate *browserDelegate;
@end

@implementation StageOneController

- (id) init {
    self = [super init];
    NSLog(@"stageOneController: init");
    return self;
    
}

- (void) awakeFromNib {
    NSLog(@"stageOnecontroller: awakeFromNib");
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    VSGlobalMetadata *md = [[VSGlobalMetadata alloc] init:[d valueForKey:@"vshost"] port:[d valueForKey:@"vsport"] username:[d valueForKey:@"vsuser"] password:[d valueForKey:@"vspass"]];
    
    NSArray *content = [md groupContent:@"WorkingGroup"];
    NSLog(@"%@",content);
    /*NSMutableArray *r = [NSMutableArray array];
    for (NSDictionary *entry in content){
        [r addObject:[entry valueForKey:@"gnm_subgroup_displayname"]];
    }
    NSLog(@"%@",r);*/
    [_browserDelegate setWorkingGroups:content];
}
- (void)windowDidLoad {
    [super windowDidLoad];
    NSLog(@"stageOneController: windowDidLoad");
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
