//
//  SubgroupValueTransformer.m
//  PlutoProjectCreator
//
//  Created by localhome on 29/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "SubgroupValueTransformer.h"

@implementation SubgroupValueTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+(BOOL) allowsReverseTransformation
{
    return NO;
}

-(NSString *)transformedValue:(NSDictionary *)value
{
    NSString *val;
    /*NSLog(@"SubgroupValueTransformer::transformedValue()");
    NSLog(@"%@: %@",[value class],value);*/
    //abort();
    /*NSMutableArray *rtn=[NSMutableArray array];
    
    for (NSDictionary *type in value ){
        NSString *name = [type valueForKey:@"gnm_subgroup_displayname"];
        if(name!=nil) [rtn addObject:name];
    }
    //return [value valueForKey:@"gnm_projectsubtype_displayname"];
    return rtn;*/
    NSLog(@"subgroupVAlueTransformer: got %@",value);
    val = [value valueForKey:@"gnm_subgroup_displayname"];
    if(!val)
        val = [value valueForKey:@"gnm_projectsubtype_projecttype"];
    return val;
}
@end

/*
@implementation ProjectTypeValueTransformer

+ (Class)transformedValueClass
{
    return [NSArray class];
}

+ (BOOL) allowsReverseTransformation
{
    return NO;
}

- (NSArray *)transformedValue:(NSArray *)value
{
    NSMutableArray *rtn = [NSMutableArray array];
    
    for (NSDictionary *proj in value){
        NSString *name = [proj valueForKey:@"gnm_subgroup_displayname"];
    }
}
@end*/
