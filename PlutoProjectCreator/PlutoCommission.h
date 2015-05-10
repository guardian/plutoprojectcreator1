//
//  PlutoCommission.h
//  PlutoProjectCreator
//
//  Created by localhome on 08/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "PlutoContainer.h"

#ifndef __plutocontainer_h_
#define __plutocontainer_h_

@interface PlutoCommission : PlutoContainer

@property (copy) NSString *commissionName;
@property (copy) NSDictionary *workingGroupRef;
@property (copy) NSString *commissionerName;
@property (copy) NSString *client;
@property (copy) NSDate *projectedCompletion;

+ (PlutoCommission *)commissionWithVSID:(NSString *)vsid;

@end
#endif