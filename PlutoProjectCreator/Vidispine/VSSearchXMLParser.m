//
//  VSSearchXMLParser.m
//  VSSearchTest
//
//  Created by localhome on 09/10/2014.
//  Copyright (c) 2014 Guardian News & Media. All rights reserved.
//

#import "VSSearchXMLParser.h"
#import "VSItem.h"

@implementation VSSearchXMLParser
@synthesize delegate;

- (id)init
{
    elementStack=[NSMutableArray array];
    currentFieldName=@"";
    itemMetadata=[NSMutableDictionary dictionary];
    
    itemID=@"";
    _debugLevel=0;
    return self;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if(_debugLevel>0)
        NSLog(@"info: parser ended element %@ at line %lu col %lu",elementName,[parser lineNumber],[parser columnNumber]);

    if([elementName compare:@"item"]==0 || [elementName compare:@"collection"]==0){
        if(_debugLevel>0)
            NSLog(@"info: building item");
        VSItem *i=[[VSItem alloc] init];
        [i setVsClass:elementName];
        [i setItemId:itemID];
        for(NSString *key in itemMetadata){
            if(_debugLevel>0)
                NSLog(@"\t%@: %@",key,[itemMetadata valueForKey:key]);
            [i setValue:[itemMetadata valueForKey:key] forKey:key append:false];
        }
        [delegate gotNewItem:i];
        itemMetadata=[NSMutableDictionary dictionary];
        currentFieldName=@"";
        itemID=nil;
    }
    [elementStack removeLastObject];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if(_debugLevel>1)
        NSLog(@"info: parser started element %@, at line %lu col %lu",elementName,[parser lineNumber],[parser columnNumber]);
    NSString *previousLevelElementName = [elementStack lastObject];
    
    [elementStack addObject:elementName];
    
    if([elementName compare:@"item"]==0 || [elementName compare:@"collection"]==0){
        itemID=[attributeDict valueForKey:@"id"];
        if(_debugLevel>1)
            NSLog(@"info: parser got new item with id %@",itemID);
        return;
    }
    
    if([elementName compare:@"name"]==0 && previousLevelElementName && [previousLevelElementName compare:@"field"]==0){
        currentFieldName=@""; // if we've got a field name, then blank the current name in preparation for receiving characters
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(_debugLevel>1)
        NSLog(@"info: parser found characters: %@",string);
    
    NSInteger atLevel = [elementStack count];
    NSString *elementName = [elementStack lastObject];
    NSString *previousLevelElementName=nil;
    if(atLevel>1){
       previousLevelElementName =[elementStack objectAtIndex:atLevel -2];
    }
    
    if(_debugLevel>1)
        NSLog(@"debug: level is %lu, current element %@, previous element %@",(long)atLevel,elementName,previousLevelElementName);
    
    if([elementName compare:@"name"]==0 && previousLevelElementName && [previousLevelElementName compare:@"field"]==0){
        if(_debugLevel>2)
            NSLog(@"debug: setting current field name to %@",string);
        currentFieldName=[NSString stringWithFormat:@"%@%@",currentFieldName,string];
        return;
    }
    
    if([elementName compare:@"id"]==0 && previousLevelElementName && [previousLevelElementName compare:@"collection"]==0)
    {
        if(!itemID) itemID=@"";
        itemID=[itemID stringByAppendingString:string];
        return;
    }
    if([elementName compare:@"value"]==0 && previousLevelElementName && [previousLevelElementName compare:@"field"]==0 &&[currentFieldName length]>0){
        
        NSString *currentValue;
        currentValue = [itemMetadata valueForKey:currentFieldName];
        if(!currentValue) currentValue = @"";
        
        if(_debugLevel>1)
            NSLog(@"debug: setting value for metadata key %@ to %@",currentFieldName,string);
        
        [itemMetadata setValue:[currentValue stringByAppendingString:string] forKey:currentFieldName];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"XML parser error: %@",[parseError localizedDescription]);
}

@end
