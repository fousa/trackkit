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

typedef enum : NSUInteger {
    FITFileTypeActivity = 4,
    FITFileTypeCourse = 6,
    FITFileTypeSegment = 34
} FITFileType;

@implementation FITFile (Init)

#pragma mark - Init

- (instancetype)initWithFileId:(fit::FileIdMesg)fileId
                    activities:(std::list<fit::ActivityMesg>)activities
                       records:(std::list<fit::RecordMesg>)records
                          laps:(std::list<fit::LapMesg>)laps
                 segmentPoints:(std::list<fit::SegmentPointMesg>)segmentPoints {
    if (self = [super init]) {
        if (fileId.GetType() == FITFileTypeActivity) {
            [self parseFromRecords:records laps:laps];
        } else if (fileId.GetType() == FITFileTypeSegment) {
            [self parseFromSegmentPoints:segmentPoints];
        } else if (fileId.GetType() == FITFileTypeCourse) {
            [self parseFromRecords:records];
        } else {
            return nil;
        }
    }
    return self;
}

#pragma mark - Parsing

- (void)parseFromRecords:(std::list<fit::RecordMesg>)records
                    laps:(std::list<fit::LapMesg>)laps {
    if (FITActivity *activity = [[FITActivity alloc] initWithRecords:records laps:laps]) {
        self.activities = [NSArray arrayWithObject:activity];
    }
}

- (void)parseFromSegmentPoints:(std::list<fit::SegmentPointMesg>)segmentPoints {
    if (FITCourse *course = [[FITCourse alloc] initWithSegmentPoints:segmentPoints]) {
        self.courses = [NSArray arrayWithObject:course];
    }
}

- (void)parseFromRecords:(std::list<fit::RecordMesg>)records {
    if (FITCourse *course = [[FITCourse alloc] initWithRecords:records]) {
        self.courses = [NSArray arrayWithObject:course];
    }
}

@end
