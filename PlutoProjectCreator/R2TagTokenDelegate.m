//
//  R2TagTokenDelegate.m
//  PlutoProjectCreator
//
//  Created by localhome on 01/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "R2TagTokenDelegate.h"

@implementation R2TagTokenDelegate

- (R2TagTokenDelegate *)init
{
    self = [super init];
    [self setPlutoTags:[[PlutoTags alloc] init]];
    [[self plutoTags] setHostname:@"pluto.gnm.int"];    //FIXME: make this configurable
    return self;
}

- (NSArray *)tokenField:(NSTokenField *)tokenField
completionsForSubstring:(NSString *)substring
           indexOfToken:(NSInteger)tokenIndex
    indexOfSelectedItem:(NSInteger *)selectedIndex
{
    NSLog(@"tokenField::completionsForString: %@",substring);
    
    NSError *e = nil;
    NSArray *r = [[self plutoTags] possibleCompletions:substring error:&e];
    NSLog(@"returned possible completions: %@",r);
    
    NSMutableArray *rtn = [NSMutableArray array];
    for(NSDictionary *entry in r){
        //if([[entry valueForKey:@"value"] hasPrefix:substring])
        [rtn addObject:[entry valueForKey:@"value"]];
    }
    
    if(!r){
        NSLog(@"%@",e);
    }
    return rtn;
    
}

- (NSString *)tokenField:(NSTokenField *)tokenField
displayStringForRepresentedObject:(id)representedObject
{
    NSLog(@"tokenField::displayStringForRepresentedObject - passed %@: %@",[representedObject class],representedObject);
    //return [(NSDictionary *)representedObject valueForKey:@"value"];
    return nil;
}
@end
