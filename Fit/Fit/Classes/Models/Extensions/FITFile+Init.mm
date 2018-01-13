//
//  FITFile+Init.m
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITFile+Init.h"
#import "FITActivity+Init.h"
#import "FITCourse+Init.h"

@implementation FITFile (Init)

- (instancetype)initWithActivities:(std::list<fit::ActivityMesg>)actities
                           records:(std::list<fit::RecordMesg>)records
                              laps:(std::list<fit::LapMesg>)laps
                     segmentPoints:(std::list<fit::SegmentPointMesg>)segmentPoints {
    if (self = [super init]) {
        if (FITActivity *activity = [[FITActivity alloc] initWithRecords:records laps:laps]) {
            self.activities = [NSArray arrayWithObject:activity];
        }
        if (FITCourse *course = [[FITCourse alloc] initWithSegmentPoints:segmentPoints]) {
            self.courses = [NSArray arrayWithObject:course];
        }
    }
    return self;
}

@end
