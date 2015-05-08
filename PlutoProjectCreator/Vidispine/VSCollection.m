//
//  VSCollection.m
//  PlutoProjectCreator
//
//  Created by localhome on 08/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "VSCollection.h"

@implementation VSCollection

- (id)init:(NSString *)hst port:(NSString *)pt username:(NSString *)usr password:(NSString *)pwd
{
    self = [super init:hst port:pt username:usr password:pwd];
    [self setEntityClass:@"collection"];
    return self;
}

@end
