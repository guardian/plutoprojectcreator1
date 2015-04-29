//
//  BrowserDelegate.h
//  treeviewtest
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AppKit;

#define COL_WORKINGGROUP    0
#define COL_COMMISSION      1
#define COL_PROJECTNAME     2

@interface BrowserDelegate : NSObject <NSBrowserDelegate>
//- (bool) setWorkingGroupArray:(NSArray *)a;
@property (atomic,retain) NSArray *workingGroups;
@property (atomic,retain) NSMutableDictionary *commissionsByGroup;
@property (atomic,retain) NSMutableDictionary *projectsByCommission;

- (NSArray *)getCommissionList:(NSDictionary *)workingGroup;
- (NSDictionary *)selectedWorkingGroup:(NSBrowser *)sender;
- (NSDictionary *)selectedCommission:(NSBrowser *)sender;
@end
