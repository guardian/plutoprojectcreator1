//
//  VSEntity.h
//  PlutoProjectCreator
//
//  Created by localhome on 08/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "VidispineBase.h"

@interface VSEntity : VidispineBase

@property (copy) NSString *entityClass;
@property (copy,readonly) NSURL *baseURL;
@property (copy,readonly) NSString *vsid;
@property (strong) NSXMLDocument *metadataDoc;

- (bool) createWithMetadata:(NSDictionary *)meta title:(NSString *)title error:(NSError **)e;
- (bool) populate;
@end
