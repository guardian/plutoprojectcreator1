//
//  PlutoProject.h
//  PlutoProjectCreator
//
//  Created by localhome on 10/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "PlutoContainer.h"
#import "PlutoCommission.h"

#ifndef __plutoproject_h_
#define __plutoproject_h_

@interface PlutoProject : PlutoContainer

/*
@property (copy) NSString *headline;
@property (copy) NSString *standfirst;
@property (copy) NSString *byline;
@property (copy) NSString *trail;
*/
@property (nonatomic,retain) NSString *selectedProjectType;
@property (nonatomic,retain) NSString *selectedProjectSubType;

@property (nonatomic,retain) NSString *headline;
@property (nonatomic,retain) NSString *byline;
@property (nonatomic,retain) NSString *standfirst;
@property (nonatomic,retain) NSString *trail;
@property (nonatomic,retain) NSDate *publishDate;
@property (nonatomic,retain) NSDate *removeDate;

@property () bool ukonly;
@property () bool whollyOwned;
@property () bool deletable;
@property () bool explicitContent;
@property () bool deepArchive;
@property () bool sensitiveContent;

@property (nonatomic,retain) NSArray *tags;

@property (nonatomic,retain) NSDictionary *workingGroup;
@property (nonatomic,retain) NSDictionary *commissionInfo;

@property (strong) PlutoCommission *commissionRef;

/*
+ (PlutoProject *)projectWithHeadline:(NSString *)head standfirst:(NSString *)stand byline:(NSString *)by trail:(NSString *)trail commission:(PlutoCommission *)comm;
+ (PlutoProject *)projectForCommission:(PlutoCommission *)comm;
*/

- (bool)saveWithError:(NSError **)err;
- (bool) saveToServer:(NSString *)host port:(NSUInteger)port user:(NSString *)user password:(NSString *)pass;

@end

#endif
