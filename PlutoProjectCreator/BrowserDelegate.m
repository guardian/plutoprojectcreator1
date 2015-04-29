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
    
    _commissionsByGroup = [NSMutableDictionary dictionary];
    _projectsByCommission = [NSMutableDictionary dictionary];
    
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
- (BOOL)browser:(NSBrowser *)sender
selectCellWithString:(NSString *)title
       inColumn:(NSInteger)column
{
    NSLog(@"selectCellWithString: %@",title);
    return TRUE;
}

- (NSDictionary *)selectedWorkingGroup:(NSBrowser *)sender
{
    NSIndexPath *p = [sender selectionIndexPath];
    NSUInteger i=[p indexAtPosition:COL_WORKINGGROUP];
    return [_workingGroups objectAtIndex:i];
}

- (NSDictionary *)selectedCommission:(NSBrowser *)sender
{
    NSIndexPath *p = [sender selectionIndexPath];
    NSUInteger i=[p indexAtPosition:COL_COMMISSION];
    
    NSArray *list = [self getCommissionList:[self selectedWorkingGroup:sender]];
    //return [_commissionsByGroup]
    return [list objectAtIndex:i];
}

- (NSInteger)browser:(NSBrowser *)sender
numberOfRowsInColumn:(NSInteger)column
{
    NSArray *list=nil;
    NSCell *wg_cell=nil,*comm_cell=nil;
    NSUInteger i=0;
    NSIndexPath *p=nil;
    NSDictionary *selected_commission;
    
    switch(column){
        case COL_WORKINGGROUP:
            if(!_workingGroups){
                NSLog(@"WARNING: browser:numberOfRowsInColumn - no working groups set");
                return 0;
            }
            return [_workingGroups count];
            break;
        case COL_COMMISSION:
            wg_cell = [sender selectedCellInColumn:COL_WORKINGGROUP];
            p=[sender selectionIndexPath];
            i=[p indexAtPosition:COL_WORKINGGROUP];
            //i = [_workingGroups indexOfObject:[wg_cell stringValue]];
            NSLog(@"commission request for working group %@ at index %ld",[wg_cell stringValue],i);
            
            list = [self getCommissionList:[_workingGroups objectAtIndex:i]];
            return [list count];
            break;
        case COL_PROJECTNAME:
            comm_cell = [sender selectedCellInColumn:COL_COMMISSION];
            p=[sender selectionIndexPath];
            i=[p indexAtPosition:COL_COMMISSION];
            NSLog(@"project request for commission %@ at index %ld",[comm_cell stringValue],i);
            
            list = [self getCommissionList:[_workingGroups objectAtIndex:i]];
            selected_commission = [list objectAtIndex:i];
            
            list = [self getProjectList:[selected_commission valueForKey:@"id"]];
            return [list count]+1;
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
    NSIndexPath *p;
    NSUInteger i;
    NSDictionary *entity,*selected_commission;
    NSCell *comm_cell;
    
    switch(column){
        case COL_WORKINGGROUP:
            groupInfo = [_workingGroups objectAtIndex:row];
            [cell setStringValue:[groupInfo valueForKey:@"gnm_subgroup_displayname"]];
            //[cell setObjectValue:groupInfo];
            break;
        case COL_COMMISSION:
            p=[sender selectionIndexPath];
            i=[p indexAtPosition:COL_WORKINGGROUP];
            list = [self getCommissionList:[_workingGroups objectAtIndex:i]];
            //NSLog(@"%@",list);
            [cell setImage:commissionIcon];
            entity = [list objectAtIndex:row];
            
            str = [NSString stringWithFormat:@"%@ (%@)",[entity valueForKey:@"name"],[entity valueForKey:@"id"]];
            
            [cell setStringValue:str];
            break;
        case COL_PROJECTNAME:
            comm_cell = [sender selectedCellInColumn:COL_COMMISSION];
            p=[sender selectionIndexPath];
            i=[p indexAtPosition:COL_COMMISSION];
            NSLog(@"project request for commission %@ at index %ld",[comm_cell stringValue],i);
            
            list = [self getCommissionList:[_workingGroups objectAtIndex:[p indexAtPosition:COL_WORKINGGROUP]]];
            selected_commission = [list objectAtIndex:i];
            
            list = [self getProjectList:[selected_commission valueForKey:@"id"]];
            
            entity = [list objectAtIndex:row];
            
            str = [entity valueForKey:@"name"];
            [cell setImage:projectIcon];
            [cell setStringValue:str];
            [cell setLeaf:NO];
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

- (NSArray *)getProjectList:(NSString *)commissionID
{
    NSArray *result = [_projectsByCommission objectForKey:commissionID];
    if(result)
        return result;
    
    NSLog(@"getProjectList for commission ID %@",commissionID);
    
    if(commissionID==nil) abort();
    result = [self downloadProjectList:commissionID];
    [_projectsByCommission setObject:result forKey:commissionID];
    return result;
}

- (NSArray *)getCommissionList:(NSDictionary *)workingGroup
{
    NSString *name = [workingGroup valueForKey:@"gnm_subgroup_displayname"];
    
    NSArray *result = [_commissionsByGroup objectForKey:name];
    if(result)
        return result;
    
    result = [self downloadCommissionList:workingGroup];
    
    /*cache result for later*/
    [_commissionsByGroup setObject:result forKey:name];
    return result;
}

- (NSArray *)downloadProjectList:(NSString *)commissionID
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    VidispineBase *conn = [[VidispineBase alloc] init:[d valueForKey:@"vshost"] port:[d valueForKey:@"vsport"] username:[d valueForKey:@"vsuser"] password:[d valueForKey:@"vspass"]];
    
    VSSearch *search = [[VSSearch alloc] initWithConnection:conn];
    
    [search addSearchTerm:@"project" forField:@"gnm_type"];
    [search addSearchTerm:commissionID forField:@"__ancestor_collection"];
    
    NSXMLDocument *returnedXML = [search executeWithoutDelegation];
    
    NSLog(@"%@",returnedXML);
    

    return [self processSearchXML:returnedXML];
}

- (NSArray *)downloadCommissionList:(NSDictionary *)workingGroup
{
    NSString *uuid = [workingGroup valueForKey:@"uuid"];
    
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    VidispineBase *conn = [[VidispineBase alloc] init:[d valueForKey:@"vshost"] port:[d valueForKey:@"vsport"] username:[d valueForKey:@"vsuser"] password:[d valueForKey:@"vspass"]];
    
    VSSearch *search = [[VSSearch alloc] initWithConnection:conn];
    
    [search addSearchTerm:@"Commission" forField:@"gnm_type"];
    [search addSearchTerm:uuid forField:@"gnm_commission_workinggroup"];
    
    NSXMLDocument *returnedXML = [search executeWithoutDelegation];
    
    NSLog(@"%@",returnedXML);
    
    return [self processSearchXML:returnedXML];
}

- (NSArray *)processSearchXML:(NSXMLDocument *)returnedXML
{
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
