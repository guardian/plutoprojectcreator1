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
    //NSLog(@"tokenField::completionsForString: %@",substring);
    
    NSError *e = nil;
    _knownTagData = [[self plutoTags] possibleCompletions:substring error:&e];
    //NSLog(@"returned possible completions: %@",r);
    
    /*tag field just wants to have strings returned*/
    NSMutableArray *rtn = [NSMutableArray array];
    _tagLookup = [NSMutableDictionary dictionary];
    
    for(NSDictionary *entry in _knownTagData){
        //if([[entry valueForKey:@"value"] hasPrefix:substring])
        [rtn addObject:[entry valueForKey:@"value"]];
        [_tagLookup setValue:entry forKey:[entry valueForKey:@"value"]];
    }
    
    if(!_knownTagData){
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

- (NSArray *)tokenField:(NSTokenField *)tokenField
       shouldAddObjects:(NSArray *)tokens
                atIndex:(NSUInteger)index
{
    NSLog(@"tokenField::shouldAddObjects passed %@",tokens);
    NSMutableArray *rtn = [NSMutableArray array];
    NSString *errorString=[NSString string];
    
    for(NSString *t in tokens){
        if([_tagLookup objectForKey:t])
            [rtn addObject:t];
        else {
            errorString = [errorString stringByAppendingFormat:@"'%@' is not a valid R2 tag\n",t];
        }
    }
    if(![errorString isEqual:@""]){
        [_tokenMessage setStringValue:errorString];
    }
    return rtn;
}
@end
