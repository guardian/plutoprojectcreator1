//
//  VSEntity.m
//  PlutoProjectCreator
//
//  Created by localhome on 08/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "VSEntity.h"

@implementation VSEntity

- (bool) populate
{
    NSString *path = [NSString stringWithFormat:@"/%@/%@/metadata", [self entityClass], [self vsid]];
    VSRequest *req = [[VSRequest alloc] init:path queryPart:nil matrixPart:nil];
    [req setMethod:@"GET"];
    
    [self setMetadataDoc:[self makeRequest:req]];
    if(_metadataDoc) return true;
    return false;
}

- (void) recurseCreateDocument:(NSXMLElement *)parentElem meta:(NSDictionary *)meta parentStack:(NSMutableArray *)parentStack namespace:(NSString *)ns
{
    NSXMLElement *e=nil,*name=nil,*val=nil;
    const char *numericType;
    
    for(NSString *key in meta){
        id value = [meta objectForKey:key];
        NSLog(@"Got type %@ for key %@",[value class],key);
        if([value isKindOfClass:[NSDictionary class]]){
            e = [[NSXMLElement alloc] initWithName:@"group" URI:ns];
            [e setAttributesWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:key,@"name",@"add",@"mode", nil]];
            [self recurseCreateDocument:e meta:value parentStack:nil namespace:ns];
            [parentElem addChild:e];
        }  else if([value isKindOfClass:[NSNumber class]]){
            numericType = [value objCType];
            NSLog(@"number got data type %s", numericType);
            e = [[NSXMLElement alloc] initWithName:@"field" URI:ns];
            name = [[NSXMLElement alloc] initWithName:@"name" URI:ns];
            [name setStringValue:key];
            [e addChild:name];
            val = [[NSXMLElement alloc] initWithName:@"value" URI:ns];
            [val setStringValue:[value stringValue]];
            [e addChild:val];
            [parentElem addChild:e];
        } else if([value isKindOfClass:[NSString class]]){
            e = [[NSXMLElement alloc] initWithName:@"field" URI:ns];
            name = [[NSXMLElement alloc] initWithName:@"name" URI:ns];
            [name setStringValue:key];
            [e addChild:name];
            val = [[NSXMLElement alloc] initWithName:@"value" URI:ns];
            [val setStringValue:value];
            [e addChild:val];
            [parentElem addChild:e];
        } else if([value isKindOfClass:[NSArray class]]){
            e = [[NSXMLElement alloc] initWithName:@"field" URI:ns];
            name = [[NSXMLElement alloc] initWithName:@"name" URI:ns];
            [name setStringValue:key];
            [e addChild:name];
            
            for(NSString *v in value){
                val = [[NSXMLElement alloc] initWithName:@"value" URI:ns];
                [val setStringValue:v];
                [e addChild:val];
            }
            [parentElem addChild:e];
        } else {
            NSLog(@"warning: unrecognised type %@ for metadata key %@",[value class],key);
        }
    }
}

- (bool) createWithMetadata:(NSDictionary *)meta title:(NSString *)title error:(NSError **)e
{
    [self setMetadataDoc:[[NSXMLDocument alloc] init]];
    NSString *ns=@"http://xml.vidispine.com/schema/vidispine";
    NSXMLElement *root = [[NSXMLElement alloc] initWithName:@"MetadataDocument" URI:ns];
    [root addNamespace:[NSXMLNode namespaceWithName:@"" stringValue:ns]];
    
    [_metadataDoc setCharacterEncoding:@"UTF-8"];
    [_metadataDoc setRootElement:root];
    
    NSXMLElement *timespan = [[NSXMLElement alloc] initWithName:@"timespan" URI:ns];
    NSDictionary *tselem = [NSDictionary dictionaryWithObjectsAndKeys:@"-INF",@"start",@"+INF",@"end", nil];
    [timespan setAttributesWithDictionary:tselem];
    [root addChild:timespan];
    
    //NSMutableArray *parentStack = [NSMutableArray arrayWithObject:timespan];
    [self recurseCreateDocument:timespan meta:meta parentStack:nil namespace:ns];
    
    NSLog(@"%@",[[NSString alloc] initWithData:[_metadataDoc XMLData] encoding:NSUTF8StringEncoding]);
    
    //[self setDebug:TRUE];
    NSString *path = [NSString stringWithFormat:@"/%@", [self entityClass]];
    NSString *param=[NSString stringWithFormat:@"name=%@", title];
    VSRequest *req = [[VSRequest alloc] init:path queryPart:[NSArray arrayWithObjects:param, nil] matrixPart:nil];
    [req setMethod:@"POST"];
    [req setBody:[[NSString alloc] initWithData:[_metadataDoc XMLData] encoding:NSUTF8StringEncoding]];
    
    NSUInteger returnCode=-1;
    NSXMLDocument *returnedXML = [self makeRequestFull:req returnCode:&returnCode error:nil];
    //if(!returnedXML) return false;
    if(returnCode>299 || returnCode < 200){
        NSLog(@"Unable to perform creation request to Vidispine, return code %lu",returnCode);
        if(returnedXML) NSLog(@"%@",[returnedXML XMLString]);
        if(e){
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:returnedXML,@"returnedXML",[returnedXML XMLString], @"returnedString", nil];
            *e = [NSError errorWithDomain:@"vidispine" code:returnCode userInfo:errorInfo];
        }
        return false;
    }
    //NSError *lookupError=nil;
    
    NSArray *locNodeList = [returnedXML nodesForXPath:@"//loc" error:e];
    if(!locNodeList) return false;
    NSXMLElement *locNode = [locNodeList objectAtIndex:0];
    _baseURL = [NSURL URLWithString:[locNode stringValue]];
    
    NSArray *idNodeList = [returnedXML nodesForXPath:@"//id" error:e];
    if(!idNodeList) return false;
    NSXMLElement *idNode = [idNodeList objectAtIndex:0];
    _vsid = [idNode stringValue];
    
    NSLog(@"created collection at address %@ with ID %@",_baseURL,_vsid);
    
    NSLog(@"created metadata document:");
    
    NSString *documentData = [_metadataDoc XMLString];
    NSLog(@"%@",documentData);
    
    path = [NSString stringWithFormat:@"/%@/%@/metadata", [self entityClass], [self vsid]];
    VSRequest *mdreq = [[VSRequest alloc] init:path queryPart:nil matrixPart:nil];
    [mdreq setMethod:@"PUT"];
    [mdreq setBody:documentData];
    
    NSError *err=nil;
    returnedXML = [self makeRequestFull:mdreq returnCode:&returnCode error:&err];
    if(returnCode<200 || returnCode>299){
        NSLog(@"Unable to set metadata on %@",_vsid);
        NSLog(@"Vidispine said: %@", [returnedXML XMLString]);
    }
    /*NSLog(@"");
    NSLog(@"vidispine said:");
    NSLog(@"%@",[returnedXML XMLString]);*/
    return true;
}

- (id)metadataValueForKey:(NSString *)key
{
    return nil;
}
@end
