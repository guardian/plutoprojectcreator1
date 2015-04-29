//
//  StageTwoController.m
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "StageTwoController.h"
#import "StageOneController.h"
#import "BrowserDelegate.h"

@interface StageTwoController ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSWindow *stageOneWindow;
@property (weak) IBOutlet NSWindowController *stageOneController;
@property (weak) IBOutlet BrowserDelegate *stageOneBrowserDelegate;

@end

@implementation StageTwoController
@synthesize workingGroup;
@synthesize commission;

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (StageTwoController *) init
{
    self=[super init];
    
    [self addObserver:self forKeyPath:@"workingGroup" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:Nil];
    [self addObserver:self forKeyPath:@"commission" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath: got change %@ for key %@",change,keyPath);
    if([keyPath isEqual:@"workingGroup"]){
        
    }
}

- (void)nextClicked:(id)sender
{
    
}

- (void)prevClicked:(id)sender
{
    [[self window] orderOut:sender];
    [_stageOneController showWindow:sender];
}

@end
