//
//  VSSearchXMLParser.h
//  VSSearchTest
//
//  Created by localhome on 09/10/2014.
//  Copyright (c) 2014 Guardian News & Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSearch.h"

@interface VSSearchXMLParser : NSObject
{
    NSString *currentFieldName;
    NSMutableArray *elementStack;
    
    NSMutableDictionary *itemMetadata;
    NSString *itemID;
    
    id <VSSearchDelegateProtocol> delegate; //this is called when we get items completed
}
@property (atomic) id delegate;
@property (atomic) int debugLevel;

/*– parserDidStartDocument:
 – parserDidEndDocument:
 – parser:didStartElement:namespaceURI:qualifiedName:attributes:
 – parser:didEndElement:namespaceURI:qualifiedName:
 – parser:didStartMappingPrefix:toURI:
 – parser:didEndMappingPrefix:
 – parser:resolveExternalEntityName:systemID:
 – parser:parseErrorOccurred:
 – parser:validationErrorOccurred: - not currently used
 – parser:foundCharacters:
 – parser:foundIgnorableWhitespace:
 – parser:foundProcessingInstructionWithTarget:data:
 – parser:foundComment:
 – parser:foundCDATA:
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;

@end
