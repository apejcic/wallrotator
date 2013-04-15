//
//  Misc.m
//  Wallrotator
//
//  Created by Aleksander Pejcic on 4/15/13.
//  Copyright (c) 2013 Aleksander Pejcic. All rights reserved.
//

#import "Misc.h"

@implementation Misc

+ (NSURL*)pathInApplicationDirectory:(NSString *)filename
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *appSupportDir = [fm URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
    if ([appSupportDir count] == 0) 
        [NSException raise:@"Create applicatio directory failed." format:@"Err"];

    NSURL *dirPath = [[appSupportDir objectAtIndex:0] URLByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
    
    NSError *err = nil;
    if (![fm createDirectoryAtURL:dirPath withIntermediateDirectories:YES attributes:nil error:&err])
        [NSException raise:@"Create application directory failed." format:@"Err: %@", [err localizedDescription]];
    
    return [dirPath URLByAppendingPathComponent:filename];
}


@end
