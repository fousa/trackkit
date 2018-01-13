//
//  FITLap.m
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITLap.h"
#import "FitParser.h"

@interface FITLap ()

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSNumber *totalTime;
@property (nonatomic, strong) NSNumber *totalDistance;
@property (nonatomic, strong) NSNumber *maximumSpeed;
@property (nonatomic, strong) NSNumber *totalCalories;
@property (nonatomic, strong) NSNumber *averageHeartRate;
@property (nonatomic, strong) NSNumber *maximumHeartRate;
@property (nonatomic, strong) NSNumber *averageCadence;
@property (nonatomic, strong) NSArray<FITPoint *> *points;

@end

@implementation FITLap

#pragma mark - Init

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

