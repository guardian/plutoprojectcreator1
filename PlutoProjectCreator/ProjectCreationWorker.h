//
//  ProjectCreationWorker.h
//  PlutoProjectCreator
//
//  Created by localhome on 06/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef __projectCreationWorker_h
#define __projectCreationWorker_h
#import "ProgressWindowController.h"
#import "VSGlobalMetadata.h"
#import "StageTwoController.h"

@interface ProjectCreationWorker : NSThread
@property (strong) ProgressWindowController *progressWindowController;
@property (strong) VSGlobalMetadata *globalMetadata;
@property (strong) VidispineBase *vidispineConnection;
@property (strong) PlutoProject *plutoProject;

@property (weak) StageTwoController *formDialog;

-(void)main;

@end

#endif
