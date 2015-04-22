//
//  BrowserDelegate.m
//  treeviewtest
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "BrowserDelegate.h"
#import "VSSearch.h"

@implementation BrowserDelegate
NSImage *commissionIcon,*projectIcon;

- (BrowserDelegate *)init
{
    commissionIcon = [self resizeImage:[NSImage imageNamed:@"icon_commission"] size:NSSizeFromString(@"{12,12}")];
    
    projectIcon = [self resizeImage:[NSImage imageNamed:@"icon_project"] size:NSSizeFromString(@"{12,12}")];
    return self;
}

- (BOOL)browser:(NSBrowser *)sender
  isColumnValid:(NSInteger)column
{
    return NO;  //always reload column when asked
}

//with thanks to http://stackoverflow.com/questions/15587527/scale-up-nsimage-and-save
- (NSImage*) resizeImage:(NSImage*)sourceImage size:(NSSize)size
{
    
    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
    NSImage* targetImage = nil;
    NSImageRep *sourceImageRep =
    [sourceImage bestRepresentationForRect:targetFrame
                                   context:nil
                                     hints:nil];
    
    targetImage = [[NSImage alloc] initWithSize:size];
    
    [targetImage lockFocus];
    [sourceImageRep drawInRect: targetFrame];
    [targetImage unlockFocus];
    
    return targetImage;
}

- (NSInteger)browser:(NSBrowser *)sender
numberOfRowsInColumn:(NSInteger)column
{
    switch(column){
        case COL_WORKINGGROUP:
            if(!_workingGroups){
                NSLog(@"WAARNING: browser:numberOfRowsInColumn - no working groups set");
                return 0;
            }
            return [_workingGroups count];
            break;
        case COL_COMMISSION:
            return 3;
            break;
        case COL_PROJECTNAME:
            return 4;
            break;
        default:
            return 0;
    }
    return 0;
}

- (NSInteger)browser:(NSBrowser *)browser
numberOfChildrenOfItem:(id)item
{
    NSLog(@"numberOfChildrenOfItem called on %@",item);
    return 0;
}

- (NSString *)browser:(NSBrowser *)sender
        titleOfColumn:(NSInteger)column
{
    switch(column){
        case COL_WORKINGGROUP:
            return @"Working Group";
        case COL_COMMISSION:
            return @"Commission";
        default:
            return @"";
    }
}

- (void)browser:(NSBrowser *)sender
willDisplayCell:(id)cell
          atRow:(NSInteger)row
         column:(NSInteger)column
{
    NSString *str = [NSString stringWithFormat:@"test value for row %ld, column %ld",(long)row,(long)column];
    NSDictionary *groupInfo = nil;
    NSArray *list;
    switch(column){
        case COL_WORKINGGROUP:
            groupInfo = [_workingGroups objectAtIndex:row];
            [cell setStringValue:[groupInfo valueForKey:@"gnm_subgroup_displayname"]];
            break;
        case COL_COMMISSION:
            list = [self getCommissionList:[_workingGroups objectAtIndex:0]];
            [cell setImage:commissionIcon];
            [cell setStringValue:str];
            break;
        case COL_PROJECTNAME:
            [cell setImage:projectIcon];
            [cell setStringValue:str];
            break;
        default:
            [cell setStringValue:@"invalid column"];
            break;
    }
    
}

- (BOOL)browser:(NSBrowser *)browser
     isLeafItem:(id)item
{
    return NO;
}

- (BOOL)browser:(NSBrowser *)browser
shouldShowCellExpansionForRow:(NSInteger)row
         column:(NSInteger)column
{
    return YES;
}

- (NSArray *)getCommissionList:(NSDictionary *)workingGroup
{
    NSString *uuid = [workingGroup valueForKey:@"uuid"];
    
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    VidispineBase *conn = [[VidispineBase alloc] init:[d valueForKey:@"vshost"] port:[d valueForKey:@"vsport"] username:[d valueForKey:@"vsuser"] password:[d valueForKey:@"vspass"]];
    
    VSSearch *search = [[VSSearch alloc] initWithConnection:conn];
    
    [search addSearchTerm:@"Commission" forField:@"gnm_type"];
    [search addSearchTerm:uuid forField:@"gnm_commission_workinggroup"];
    
    NSXMLDocument *returnedXML = [search executeWithoutDelegation];
    
    NSLog(@"%@",returnedXML);
    
    NSMutableArray *r = [NSMutableArray array];
    for (NSXMLElement *n in [returnedXML nodesForXPath:@"//entry/collection" error:nil]){
        NSLog(@"%@",n);
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        NSString *itemID = [[[n nodesForXPath:@"id" error:nil] objectAtIndex:0] stringValue];
        NSString *itemName = [[[n nodesForXPath:@"name" error:nil] objectAtIndex:0] stringValue];
        [d setObject:itemID forKey:@"id"];
        [d setObject:itemName forKey:@"name"];
        [r addObject:d];
    }
    return r;
}
@end
