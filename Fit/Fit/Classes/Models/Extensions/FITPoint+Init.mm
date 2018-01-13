//
//  FITPoint+Init.m
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "FITPoint+Init.h"
#import "FitParser.h"

#include "fit_record_mesg.hpp"

@implementation FITPoint (Init)

#pragma mark - Init

- (instancetype)initWithRecord:(fit::RecordMesg)record {
    if (self = [super init]) {
        [self parseCoordinateForRecord:record];
        if (!CLLocationCoordinate2DIsValid(self.coordinate)) { return nil; }
        
        self.time = [FitParser parseTimestamp:record.GetTimestamp() isValid:record.IsTimestampValid()];
        self.distance = [FitParser parseFloat:record.GetDistance() isValid:record.IsDistanceValid()];
        self.elevation = [FitParser parseFloat:record.GetAltitude() isValid:record.IsAltitudeValid()];
        self.cadence = [FitParser parseInteger:record.GetCadence() isValid:record.IsCadenceValid()];
        self.heartrate = [FitParser parseInteger:record.GetHeartRate() isValid:record.IsHeartRateValid()];
    }
    return self;
}

- (instancetype)initWithSegmentPoint:(fit::SegmentPointMesg)segmentPoint {
    if (self = [super init]) {
        [self parseCoordinateForSegmentPoint:segmentPoint];
        if (!CLLocationCoordinate2DIsValid(self.coordinate)) { return nil; }
        
        self.time = [FitParser parseTimestamp:segmentPoint.GetLeaderTime(0) isValid:segmentPoint.IsLeaderTimeValid(0)];
        self.distance = [FitParser parseFloat:segmentPoint.GetDistance() isValid:segmentPoint.IsDistanceValid()];
        self.elevation = [FitParser parseFloat:segmentPoint.GetAltitude() isValid:segmentPoint.IsAltitudeValid()];
    }
    return self;
}

#pragma mark - Parsing

- (void)parseCoordinateForRecord:(fit::RecordMesg)record {
    if (record.IsPositionLatValid() && record.IsPositionLongValid()) {
        double conversion = 180.0 / pow(2, 31);
        double latitude = record.GetPositionLat() * conversion;
        double longitude = record.GetPositionLong() * conversion;
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    } else {
        self.coordinate = kCLLocationCoordinate2DInvalid;
    }
}

- (void)parseCoordinateForSegmentPoint:(fit::SegmentPointMesg)segmentPoint {
    if (segmentPoint.IsPositionLatValid() && segmentPoint.IsPositionLongValid()) {
        double conversion = 180.0 / pow(2, 31);
        double latitude = segmentPoint.GetPositionLat() * conversion;
        double longitude = segmentPoint.GetPositionLong() * conversion;
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    } else {
        self.coordinate = kCLLocationCoordinate2DInvalid;
    }
}

@end
