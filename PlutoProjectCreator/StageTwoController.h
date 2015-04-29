//
//  StageTwoController.h
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#ifndef __stage_two_controller
#define __stage_two_controller

@interface StageTwoController : NSWindowController
- (IBAction)nextClicked:(id)sender;
- (IBAction)prevClicked:(id)sender;

@property (nonatomic,retain) NSDictionary *workingGroup;
@property (nonatomic,retain) NSDictionary *commission;
@property (nonatomic,retain) NSArray *projectTypes;
@property (nonatomic,retain) NSArray *projectSubTypes;
@property (nonatomic,retain) NSString *headline;
@property (nonatomic,retain) NSString *byline;
@property (nonatomic,retain) NSString *standfirst;
@property (nonatomic,retain) NSString *tags;
@end
#endif
