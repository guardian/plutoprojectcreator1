//
//  VSSearch.h
//  VSSearchTest
//
//  Created by localhome on 09/10/2014.
//  Copyright (c) 2014 Guardian News & Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VidispineBase.h"
#import "VSItem.h"

@protocol VSSearchDelegateProtocol <NSObject>
- (void)gotNewItem:(VSItem *)item;
- (void)gotNewField:(NSString *)fieldName;
- (void)gotNewResultSet:(NSUInteger)hits;

@end

@interface VSSearch : NSObject
{
    id<VSSearchDelegateProtocol> delegate;
    VidispineBase *vsConnection;
    NSMutableArray *searchTerms;
    NSMutableArray *fieldsToShow;
}

@property (atomic) id delegate;
@property (atomic) bool shouldHighlight;
@property (atomic) NSString *highlightStart;
@property (atomic) NSString *highlightEnd;

- (VSSearch *)init;
- (VSSearch *)initWithConnection:(VidispineBase *)c;
- (VSSearch *)initWithServer:(NSString *)server port:(NSString *)port username:(NSString *)username password:(NSString *)pass;

- (void)addSearchTerm:(NSString *)value forField:(NSString *)field;

- (void)addShowField:(NSString *)fieldName;

- (NSXMLDocument *)makeSearchXML;

- (void)executeWithDelegation; //calls a SAX parser on the results and calls delegate methods when stuff is found
- (NSXMLDocument *)executeWithoutDelegation; //calls a DOM parser on the results and returns document tree

- (void)setDelegate:(id)delegate;
@end

