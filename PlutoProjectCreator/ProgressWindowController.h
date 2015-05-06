//
//  ProgressWindowController.h
//  PlutoProjectCreator
//
//  Created by localhome on 06/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#ifndef __progressWindowController_h
#define __progressWindowController_h
@interface ProgressWindowController : NSWindowController
@property (retain) NSNumber *totalSteps;
@property (retain) NSNumber *currentStep;
@property (retain) NSString *message;

@property (retain) NSString *labelText;
@property (weak) NSNumber *canClose;

- (void)updateProgress:(NSString *)msg stepNumber:(NSUInteger)step;
- (void)setFinished;
- (IBAction)closeClicked:(id)sender;
@end

#endif