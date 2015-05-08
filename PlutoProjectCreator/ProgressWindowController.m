//
//  ProgressWindowController.m
//  PlutoProjectCreator
//
//  Created by localhome on 06/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "ProgressWindowController.h"

@interface ProgressWindowController ()

@end

@implementation ProgressWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    _message = @"change me";
    _currentStep = [NSNumber numberWithInteger:0];
    _totalSteps = [NSNumber numberWithInteger:1];
}

- (void)updateProgress:(NSString *)msg stepNumber:(NSUInteger)step
{
    _message = [NSString stringWithString:msg];
    if(step<=0){
        _currentStep = [NSNumber numberWithInteger:[_currentStep integerValue]];
    } else {
        _currentStep = [NSNumber numberWithInteger:step];
    }
    [self setLabelText:[NSString stringWithFormat:@"(Step %@ of %@): %@",_currentStep,_totalSteps,_message]];
}

- (void)setFinished
{
    [self setCanClose:[NSNumber numberWithBool:TRUE]];
}

- (void)clearFinished
{
    [self setCanClose:[NSNumber numberWithBool:FALSE]];
}

- (void)closeClicked:(id)sender
{
    [self clearFinished];
    [NSApp endSheet:[self window]];
    [[self window] orderOut:sender];
}
@end
