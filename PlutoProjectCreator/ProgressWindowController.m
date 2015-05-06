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
    _currentStep = [NSNumber numberWithInteger:step];
    
    [self setLabelText:[NSString stringWithFormat:@"(Step %@ of %@): %@",_currentStep,_totalSteps,_message]];
}

@end
