//
//  VSGlobalMetadata.h
//  PlutoProjectCreator
//
//  Created by localhome on 22/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "VidispineBase.h"

@interface VSGlobalMetadata : VidispineBase
- (id)init:(NSString *)hostname port:(NSString *)port username:(NSString *)username password:(NSString *)passwd;
- (NSArray *)groupContent:(NSString *)groupName;

@property (atomic,retain) NSXMLDocument *xmlContent;
@end

