//
//  SubgroupUUIDTransformer.m
//  PlutoProjectCreator
//
//  Created by localhome on 08/12/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "SubgroupUUIDTransformer.h"

@implementation SubgroupUUIDTransformer

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
    return [value valueForKey:@"uuid"];
}

@end
