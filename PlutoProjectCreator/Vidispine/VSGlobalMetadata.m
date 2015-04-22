//
//  VSGlobalMetadata.m
//  PlutoProjectCreator
//
//  Created by localhome on 22/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "VSGlobalMetadata.h"

@implementation VSGlobalMetadata

- (id)init:(NSString *)hostname port:(NSString *)port username:(NSString *)username password:(NSString *)passwd
{
    NSLog(@"VSGlobalMetadata: init");
    self = [super init:hostname port:port username:username password:passwd];
    //[self setDebug:TRUE];
    VSRequest *rq = [[VSRequest alloc] init:@"/metadata" queryPart:[NSArray array] matrixPart:[NSArray array]];
    [rq setMethod:@"GET"];
    
    _xmlContent = [self makeRequest:rq];
    //NSLog(@"%@",_xmlContent);
    return self;
}

- (NSArray *)groupContent:(NSString *)groupName
{
    NSLog(@"VSGlobalMetadata::groupContent");
    NSString *xpString = [NSString stringWithFormat:@"//timespan/group/name[text()='%@']",groupName];
    //NSLog(@"xpath string is %@",xpString);
    
    NSError *e=nil;
    
    NSArray *nodeList = [_xmlContent nodesForXPath:xpString error:&e];
    
    NSMutableArray *rtn = [NSMutableArray array];
    //NSLog(@"got nodelist %@, error %@",nodeList,e);
    
    if(!nodeList){
        NSLog(@"%@",e);
    }
    
    for (NSXMLElement *n in nodeList) {
        //NSLog(@"got node");
        //NSLog(@"%@",n);
        NSArray *groupNodeList = [n nodesForXPath:@".." error:nil];
        NSString *uuid = [[[groupNodeList objectAtIndex:0] attributeForName:@"uuid"] stringValue];
        
        NSArray *fieldContentList = [n nodesForXPath:@"../field" error:nil];
        //NSLog(@"%@",[parentNodeList objectAtIndex:0]);
        //NSLog(@"%@",fieldContentList);
        for (NSXMLElement *f in fieldContentList){
            NSMutableDictionary *d = [NSMutableDictionary dictionary];
            NSArray *nameList = [f nodesForXPath:@"name" error:nil];
            NSArray *valueList = [f nodesForXPath:@"value" error:nil];
            NSString *value =[[valueList objectAtIndex:0] stringValue];
            NSString *key = [[nameList objectAtIndex:0] stringValue];
            //NSString *uuid = [[[valueList objectAtIndex:0] attributeForName:@"uuid"] stringValue];
            [d setObject:value forKey:key];
            [d setObject:uuid forKey:@"uuid"];
            //NSLog(@"%@",d);
            [rtn addObject:d];
        }
    }
    
    return rtn;
}
@end
