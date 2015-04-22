//
//  VSSearch.m
//  VSSearchTest
//
//  Created by localhome on 09/10/2014.
//  Copyright (c) 2014 Guardian News & Media. All rights reserved.
//

#import "VSSearch.h"
#import "VSSearchXMLParser.h"

@implementation VSSearch
@synthesize delegate;

- (VSSearch *)init
{
    delegate=nil;
    vsConnection=nil;
    searchTerms=[NSMutableArray array];
    fieldsToShow=[NSMutableArray array];
    return self;
}

- (VSSearch *)initWithConnection:(VidispineBase *)c
{
    self=[self init];
    if(!c) return self;
    
    vsConnection=c;
    
    return self;
}

- (VSSearch *)initWithServer:(NSString *)server port:(NSString *)port username:(NSString *)username password:(NSString *)pass
{
    self=[self init];
    vsConnection=[[VidispineBase alloc] init:server port:port username:username password:pass];
    return self;
}

- (void)addSearchTerm:(NSString *)value forField:(NSString *)field
{
    NSDictionary *st=[NSDictionary dictionaryWithObjectsAndKeys:value,@"value",field,@"name", nil];
    
    [searchTerms addObject:st];
}

- (void)addShowField:(NSString *)fieldName
{
    [fieldsToShow addObject:fieldName];
}

- (NSXMLDocument *)makeSearchXML
{
    NSXMLElement *rootElement = [NSXMLElement elementWithName:@"ItemSearchDocument"];
    NSXMLDocument *doc=[[NSXMLDocument alloc] initWithRootElement:rootElement];
    
    for(NSDictionary *term in searchTerms){
        NSXMLElement *termElement=[NSXMLElement elementWithName:@"field"];
        for(NSString *key in term){
            NSXMLElement *el=[NSXMLElement elementWithName:key];
            [el setStringValue:[term valueForKey:key]];
            [termElement addChild:el];
        }
        [rootElement addChild:termElement];
    }
    
    if([self shouldHighlight]){
        NSXMLElement *hiliteNode=[NSXMLElement elementWithName:@"highlight"];
        [rootElement addChild:hiliteNode];
    }
    
    return doc;
}

- (VSRequest *)makeRequest
{
    NSXMLDocument *bodyDoc=[self makeSearchXML];
    if(!bodyDoc){
        NSLog(@"ERROR: VSSearch::makeRequest: Unable to create xml body for search");
        return nil;
    }
    
    NSData *bodyData = [bodyDoc XMLData];
    NSArray *querySpec;
    
    if(fieldsToShow){
        NSString *fieldSpec=@"field=";
        for(NSString *fieldName in fieldsToShow){
            NSLog(@"adding field: %@",fieldName);
            fieldSpec=[NSString stringWithFormat:@"%@%@,",fieldSpec,fieldName];
        }
        
        NSLog(@"debug: fieldspec: %@",fieldSpec);
        querySpec=[NSArray arrayWithObjects:@"content=metadata",fieldSpec, nil];
    } else {
        querySpec=[NSArray array];
    }
    
    VSRequest *rq=[[VSRequest alloc] init:@"search" queryPart:querySpec matrixPart:nil];
    NSString *bodyText=[[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
    [rq setBody:bodyText];
    NSLog(@"XML request: %@",bodyText);
    
    [rq setMethod:@"PUT"];
    
    return rq;
}

- (void)executeWithDelegation //calls a SAX parser on the results and calls delegate methods when stuff is found

{
    if(delegate==nil){
        NSLog(@"ERROR: VSSearch::executeWithDelegation cannot be executed unless you have specified a delegate");
        return;
    }
    VSSearchXMLParser *saxInterpreter = [[VSSearchXMLParser alloc] init];
    [saxInterpreter setDelegate:delegate];
    //[saxInterpreter setDebugLevel:2];
    
    VSRequest *rq=[self makeRequest];
    [vsConnection setDebug:true];
    [vsConnection makeSAXRequest:rq parseDelegate:saxInterpreter];
    
}

- (NSXMLDocument *)executeWithoutDelegation
{
    
    VSRequest *rq=[self makeRequest];
    
    return [vsConnection makeRequest:rq];
}
@end
