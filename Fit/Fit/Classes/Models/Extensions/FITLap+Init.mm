//
//  FITLap+Init.m
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FitParser.h"
#import "FITLap+Init.h"
#import "FITPoint+Init.h"

@implementation FITLap (Init)

- (instancetype)initFromLap:(fit::LapMesg)lap
                    records:(std::list<fit::RecordMesg>)records {
    if (self = [super init]) {
        NSMutableArray *points = [NSMutableArray new];
        for (fit::RecordMesg record : records) {
            if (FITPoint *point = [[FITPoint alloc] initWithRecord:record]) {
                [points addObject:point];
            }
        }
        if (points.count == 0) { return nil; }
        
        self.points = points;
        self.startTime = [FitParser parseTimestamp:lap.GetStartTime() isValid:lap.IsStartTimeValid()];
        self.totalTime = [FitParser parseFloat:lap.GetTotalTimerTime() isValid:lap.IsTotalTimerTimeValid()];
        self.totalDistance = [FitParser parseFloat:lap.GetTotalDistance() isValid:lap.IsTotalDistanceValid()];
        self.maximumSpeed = [FitParser parseFloat:lap.GetMaxSpeed() isValid:lap.IsMaxSpeedValid()];
        self.totalCalories = [FitParser parseInteger:lap.GetTotalCalories() isValid:lap.IsTotalCaloriesValid()];
        self.averageHeartRate = [FitParser parseInteger:lap.GetAvgHeartRate() isValid:lap.IsAvgHeartRateValid()];
        self.maximumHeartRate = [FitParser parseInteger:lap.GetMaxHeartRate() isValid:lap.IsMaxHeartRateValid()];
        self.averageCadence = [FitParser parseInteger:lap.GetAvgCadence() isValid:lap.IsAvgCadenceValid()];
        
        NSLog(@"➡️ Lap with %lu", (unsigned long)self.points.count);
    }
    return self;
}

@end
