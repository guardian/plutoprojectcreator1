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

@interface StageTwoController ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSWindow *stageOneWindow;
@property (weak) IBOutlet NSWindowController *stageOneController;
@property (weak) IBOutlet BrowserDelegate *stageOneBrowserDelegate;

@end

@implementation StageTwoController
@synthesize workingGroup;
@synthesize commission;

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)awakeFromNib
{

}

- (StageTwoController *) init
{
    self=[super init];
    
    /*[self addObserver:self forKeyPath:@"workingGroup" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:Nil];
    [self addObserver:self forKeyPath:@"commission" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];*/
    [self addObserver:self forKeyPath:@"appDelegate" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];

    [self addObserver:self forKeyPath:@"selectedProjectType" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"selectedProjectSubType" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
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

- (BOOL)validateForm:(NSError **)e
{
    NSUInteger code=0;
    NSString *errormsg = [NSString string];
    
    if(_headline==nil || [_headline isEqual:@""]){
        code = code|E_INVALID_HEADLINE;
        errormsg = [errormsg stringByAppendingString:@"Headline must not be empty\n"];
    }
    if(_standfirst==nil || [_standfirst isEqual:@""]){
        code = code|E_INVALID_STANDFIRST;
        errormsg = [errormsg stringByAppendingString:@"Standfirst must not be empty\n"];
    }
    if(_byline==nil || [_byline isEqual:@""]){
        code = code|E_INVALID_BYLINE;
        errormsg = [errormsg stringByAppendingString:@"Byline must not be empty\n"];
    }
    if(_tags==nil || [_tags isEqual:@""]){
        code = code|E_INVALID_TAGS;
        errormsg = [errormsg stringByAppendingString:@"Tags must not be empty\n"];
    }
 
    if(code!=0){
        //NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:errormsg, NSLocalizedFailureReasonErrorKey, @"Form is not valid",NSLocalizedDescriptionKey,nil];
        NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:errormsg, NSLocalizedRecoverySuggestionErrorKey,@"Please correct these problems",NSLocalizedDescriptionKey, nil];
        
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
    
    if(!result){
        /*NSAlert *a = [NSAlert alertWithMessageText:@"Form is not complete"
                                     defaultButton:nil alternateButton:nil otherButton:nil
                         informativeTextWithFormat:[[validationError userInfo] valueForKey:NSLocalizedFailureReasonErrorKey]];
        */
        NSAlert *a = [NSAlert alertWithError:validationError];
        //NSLog(@"%@",[validationError localizedFailureReason]);
        //NSLog(@"%@",[[validationError userInfo] objectForKey:NSLocalizedFailureReasonErrorKey]);
        //[a setMessageText:@"Form is not complete"];
        //[a setInformativeText:[[validationError userInfo] valueForKey:NSLocalizedFailureReasonErrorKey]];
        //[a runModal];
        [a beginSheetModalForWindow:[self window] completionHandler:nil];
        return;
    }
}

- (void)prevClicked:(id)sender
{
    [[self window] orderOut:sender];
    [_stageOneController showWindow:sender];
}

@end
