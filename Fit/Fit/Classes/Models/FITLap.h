//
//  FITLap.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITPoint.h"

@interface FITLap : NSObject

@property (nonatomic, strong, nullable) NSDate *startTime;
@property (nonatomic, strong, nullable) NSNumber *totalTime;
@property (nonatomic, strong, nullable) NSNumber *totalDistance;
@property (nonatomic, strong, nullable) NSNumber *maximumSpeed;
@property (nonatomic, strong, nullable) NSNumber *totalCalories;
@property (nonatomic, strong, nullable) NSNumber *averageHeartRate;
@property (nonatomic, strong, nullable) NSNumber *maximumHeartRate;
@property (nonatomic, strong, nullable) NSNumber *averageCadence;
@property (nonatomic, strong, nonnull) NSArray<FITPoint *> *points;

@end
