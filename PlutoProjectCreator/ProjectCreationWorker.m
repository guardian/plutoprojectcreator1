//
//  ProjectCreationWorker.m
//  PlutoProjectCreator
//
//  Created by localhome on 06/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "ProjectCreationWorker.h"
#import "VSCollection.h"

@implementation ProjectCreationWorker

- (void)testWithDummyData
{
    NSMutableDictionary *testData = [NSMutableDictionary dictionary];
    [testData setValue:@"string value" forKey:@"key for string value"];
    NSMutableDictionary *groupedData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"subgroup value",@"subgroup key", nil];
    [testData setObject:groupedData forKey:@"subgroup"];
    [testData setObject:[NSArray arrayWithObjects:@"first value",@"second value",@"third value", nil] forKey:@"key for multi values"];
    
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    VSCollection *coll = [[VSCollection alloc] init:[d valueForKey:@"vshost"] port:[d valueForKey:@"vsport"] username:[d valueForKey:@"vsuser"] password:[d valueForKey:@"vspass"]];
    NSError *err=nil;
    
    [coll createWithMetadata:testData title:@"test%20commission" error:&err];
}

- (void)main
{
    [[self progressWindowController] setTotalSteps:[NSNumber numberWithInt:2]];
    [[self progressWindowController] updateProgress:@"Dummy text, waiting 10 seconds" stepNumber:1];
    
    [self testWithDummyData];
    sleep(10);
    [[self progressWindowController] updateProgress:@"Completed wait!" stepNumber:2];
    [[self progressWindowController] setFinished];
}
@end
