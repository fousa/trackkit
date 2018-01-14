//
//  AppDelegate.m
//  Test
//
//  Created by Jelle Vandebeeck on 07/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "AppDelegate.h"
#import "ActivityExample.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    ActivityExample *example = [[ActivityExample alloc] initWithFilename:@"Activity"];
//    ActivityExample *example = [[ActivityExample alloc] initWithFilename:@"Segment"];
    ActivityExample *example = [[ActivityExample alloc] initWithFilename:@"Route"];
    [example read];
    
    return YES;
}


@end
