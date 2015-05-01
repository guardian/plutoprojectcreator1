//
//  R2TagTokenDelegate.h
//  PlutoProjectCreator
//
//  Created by localhome on 01/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "PlutoTags.h"

@interface R2TagTokenDelegate : NSObject <NSTokenFieldDelegate>

@property (retain) PlutoTags *plutoTags;

- (NSArray *)tokenField:(NSTokenField *)tokenField
completionsForSubstring:(NSString *)substring
           indexOfToken:(NSInteger)tokenIndex
    indexOfSelectedItem:(NSInteger *)selectedIndex;

- (NSString *)tokenField:(NSTokenField *)tokenField
displayStringForRepresentedObject:(id)representedObject;

@end
