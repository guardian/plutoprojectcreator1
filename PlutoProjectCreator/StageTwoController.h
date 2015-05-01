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
#import "AppDelegate.h"

@interface StageTwoController : NSWindowController
- (IBAction)nextClicked:(id)sender;
- (IBAction)prevClicked:(id)sender;

@property (nonatomic,retain) NSDictionary *workingGroup;
@property (nonatomic,retain) NSDictionary *commission;
@property (nonatomic,retain) NSArray *projectTypes;
@property (nonatomic,retain) NSArray *projectSubTypes;
@property (nonatomic,retain) NSString *selectedProjectType;
@property (nonatomic,retain) NSString *selectedProjectSubType;

@property (nonatomic,retain) NSString *headline;
@property (nonatomic,retain) NSString *byline;
@property (nonatomic,retain) NSString *standfirst;
@property (nonatomic,retain) NSString *tags;

@property (weak) IBOutlet AppDelegate *appDelegate;
@end
#endif

#define E_INVALID_HEADLINE      1<<0
#define E_INVALID_BYLINE        1<<1
#define E_INVALID_STANDFIRST    1<<2
#define E_INVALID_TAGS          1<<3
#define E_INVALID_TYPE          1<<4
#define E_INVALID_SUBTYPE       1<<5
#define E_INVALID_COMMISSION    1<<6
#define E_INVALID_WORKINGGROUP  1<<7