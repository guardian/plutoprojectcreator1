//
//  PlutoTags.h
//  PlutoProjectCreator
//
//  Created by localhome on 01/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef __plutotags_h_
#define __plutotags_h_

@interface PlutoTags : NSObject
@property (retain) NSString *hostname;

- (NSArray *)possibleCompletions:(NSString *)partial error:(NSError **)e;
- (NSDictionary *)tagInfoByName:(NSString *)tagName;
- (NSDictionary *)tagInfoByID:(NSUInteger)tagID;

@end

#define E_PARAMS    1
#define E_DOWNLOAD  2
#define E_PARSE     3

#endif
