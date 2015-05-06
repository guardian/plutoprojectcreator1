//
//  ProjectCreationWorker.m
//  PlutoProjectCreator
//
//  Created by localhome on 06/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "ProjectCreationWorker.h"

@implementation ProjectCreationWorker

- (void)main
{
    [[self progressWindowController] setTotalSteps:[NSNumber numberWithInt:2]];
    [[self progressWindowController] updateProgress:@"Dummy text, waiting 10 seconds" stepNumber:1];
    sleep(10);
    [[self progressWindowController] updateProgress:@"Completed wait!" stepNumber:2];
    [[self progressWindowController] setFinished];
}
@end
