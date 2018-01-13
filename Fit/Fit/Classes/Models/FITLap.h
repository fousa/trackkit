//
//  FITLap.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FITPoint.h"

#include "fit_lap_mesg.hpp"

@interface FITLap : NSObject

@property (nonatomic, strong, readonly) NSDate *startTime;
@property (nonatomic, strong, readonly) NSNumber *totalTime;
@property (nonatomic, strong, readonly) NSNumber *totalDistance;
@property (nonatomic, strong, readonly) NSNumber *maximumSpeed;
@property (nonatomic, strong, readonly) NSNumber *totalCalories;
@property (nonatomic, strong, readonly) NSNumber *averageHeartRate;
@property (nonatomic, strong, readonly) NSNumber *maximumHeartRate;
@property (nonatomic, strong, readonly) NSNumber *averageCadence;
@property (nonatomic, strong, readonly) NSArray<FITPoint *> *points;

- (instancetype)initFromLap:(fit::LapMesg)lap
                    records:(std::list<fit::RecordMesg>)records;

@end
