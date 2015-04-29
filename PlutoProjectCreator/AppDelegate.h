//
//  AppDelegate.h
//  PlutoProjectCreator
//
//  Created by localhome on 20/04/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#ifndef __app_delegate_h
#define __app_delegate_h
#import "VSGlobalMetadata.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (retain,atomic) VSGlobalMetadata *vsGlobalMetadata;
@end
#endif