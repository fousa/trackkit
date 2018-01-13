//
//  FITLap.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITPoint.h"

@interface FITLap : NSObject

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
