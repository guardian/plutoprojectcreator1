//
//  StageTwoController.m
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "StageTwoController.h"
#import "StageOneController.h"
#import "BrowserDelegate.h"
#import "ProgressWindowController.h"
#import "ProjectCreationWorker.h"

@interface StageTwoController ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSWindow *stageOneWindow;
@property (weak) IBOutlet NSWindowController *stageOneController;
@property (weak) IBOutlet BrowserDelegate *stageOneBrowserDelegate;

@end

@implementation StageTwoController
/*@synthesize workingGroup;
@synthesize commission;
*/

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)awakeFromNib
{
    [_plutoProject setByline:NSFullUserName()];
}

- (StageTwoController *) init
{
    self=[super init];
    
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    _plutoProject = [[PlutoProject alloc] init:[d valueForKey:@"vshost"]
                                        port:[d valueForKey:@"vsport"]
                                    username:[d valueForKey:@"vsuser"]
                                    password:[d valueForKey:@"vspass"]
                   ];
    /*[self addObserver:self forKeyPath:@"workingGroup" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:Nil];
    [self addObserver:self forKeyPath:@"commission" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];*/
    [self addObserver:self forKeyPath:@"appDelegate" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];

    [_plutoProject addObserver:self forKeyPath:@"selectedProjectType" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    [_plutoProject addObserver:self forKeyPath:@"selectedProjectSubType" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath: got change %@ for key %@",change,keyPath);
    if([keyPath isEqual:@"selectedProjectType"] || [keyPath isEqual:@"selectedProjectSubType"]){
        NSDictionary *newVal = [change objectForKey:@"new"];
        NSLog(@"New value for %@: %@",keyPath,newVal);
    } else if([keyPath isEqual:@"appDelegate"]){    /*ensure that AppDelegate is set before attempting to use it! */
        _projectTypes = [[_appDelegate vsGlobalMetadata] groupContent:@"ProjectType"];
        NSLog(@"%@",_projectTypes);
        _projectSubTypes = [[_appDelegate vsGlobalMetadata] groupContent:@"ProjectSubType"];
        NSLog(@"%@",_projectSubTypes);
    }
}

//return data structures corresponding to the _tags property
- (NSArray *)tagsData
{
    NSMutableArray *rtn = [NSMutableArray array];
    
    for(NSString *name in [[self plutoProject] tags]){
        [rtn addObject:[_tagTokenDelegate tagDataForName:name]];
    }
    return rtn;
}

- (BOOL)validateForm:(NSError **)e
{
    NSUInteger code=0;
    NSString *errormsg = [NSString string];
    
    if([[self plutoProject] headline]==nil || [[[self plutoProject] headline] isEqual:@""]){
        code = code|E_INVALID_HEADLINE;
        errormsg = [errormsg stringByAppendingString:@"Headline must not be empty\n"];
    }
    if([[self plutoProject] standfirst]==nil || [[[self plutoProject] standfirst] isEqual:@""]){
        code = code|E_INVALID_STANDFIRST;
        errormsg = [errormsg stringByAppendingString:@"Standfirst must not be empty\n"];
    }
    if([[self plutoProject] byline]==nil || [[[self plutoProject] byline] isEqual:@""]){
        code = code|E_INVALID_BYLINE;
        errormsg = [errormsg stringByAppendingString:@"Byline must not be empty\n"];
    }
    if([[self plutoProject] tags]==nil || [[[self plutoProject] tags] count]==0){
        code = code|E_INVALID_TAGS;
        errormsg = [errormsg stringByAppendingString:@"Tags must not be empty\n"];
    }
 
    if(code!=0){
        /* this goes back to directly program an alert sheet in the caller */
        NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:errormsg, NSLocalizedRecoverySuggestionErrorKey, @"Please correct these problems",NSLocalizedDescriptionKey,
            nil];
        
        if(e!=nil)
            *e = [NSError errorWithDomain:@"Create Project Form" code:code userInfo:errorDict];
        return NO;
    }
    return YES;
}

- (void)nextClicked:(id)sender
{
    NSError *validationError = nil;
    
    BOOL result = [self validateForm:&validationError];
    //BOOL result = TRUE;
    
    if(!result){
        NSAlert *a = [NSAlert alertWithError:validationError];

        [a beginSheetModalForWindow:[self window] completionHandler:nil];
        return;
    }
    
    ProgressWindowController *pw = (ProgressWindowController *)[[[self appDelegate] progressWindow] delegate];
    [NSApp beginSheet:[[self appDelegate] progressWindow]
       modalForWindow:[self window]
        modalDelegate:self
       didEndSelector:@selector(progressDidEnd:returnCode:contextInfo:)
          contextInfo:nil
     ];
    
    ProjectCreationWorker *worker = [[ProjectCreationWorker alloc] init];
    [worker setProgressWindowController:pw];
    [worker setFormDialog:self];
    [worker setPlutoProject:[self plutoProject]];
    
    [worker start];
}

- (void) setWorkingGroup:(NSDictionary *)wg
{
    [_plutoProject setWorkingGroup:wg];
}

- (void) setCommission:(NSDictionary *)comm
{
    [_plutoProject setCommissionInfo:comm];
}

- (void)progressDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    
}

- (void)prevClicked:(id)sender
{
    [[self window] orderOut:sender];
    [_stageOneController showWindow:sender];
}

@end
