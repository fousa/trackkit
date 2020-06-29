//
//  FITCourse+Init.m
//  Fit
//
//  Created by Jelle Vandebeeck on 14/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FitReader.h"
#import "FITCourse+Init.h"
#import "FITPoint+Init.h"

@implementation FITCourse (Init)

- (instancetype)initWithSegmentPoints:(std::list<fit::SegmentPointMesg>)segmentPoints {
    if (self = [super init]) {
        NSMutableArray *points = [NSMutableArray array];
        for (auto&& segmentPoint : segmentPoints) {
            if (FITPoint *point = [[FITPoint alloc] initWithSegmentPoint:segmentPoint]) {
                [points addObject:point];
            }
        }
        if (points.count == 0) { return nil; }
        
        self.points = points;
        if (kEnableLogging) {
            NSLog(@"-----> Segment with %lu points", (unsigned long)self.points.count);
        }
    }
    return self;
}

- (instancetype)initWithRecords:(std::list<fit::RecordMesg>)records {
    if (self = [super init]) {
        NSMutableArray *points = [NSMutableArray array];
        for (auto&& record : records) {
            if (FITPoint *point = [[FITPoint alloc] initWithRecord:record]) {
                [points addObject:point];
            }
        }
        if (points.count == 0) { return nil; }
        
        self.points = points;
        if (kEnableLogging) {
            NSLog(@"-----> Course with %lu points", (unsigned long)self.points.count);
        }
    }
    return self;
}

@end
