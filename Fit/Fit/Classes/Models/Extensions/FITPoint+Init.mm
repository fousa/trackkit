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

- (instancetype)initWithRecord:(fit::RecordMesg)record {
    if (self = [super init]) {
        [self parseCoordinateForRecord:record];
        if (!CLLocationCoordinate2DIsValid(self.coordinate)) { return nil; }
        
        self.time = [FitParser parseTimestamp:record.GetTimestamp() isValid:record.IsTimestampValid()];
        self.distance = [FitParser parseFloat:record.GetDistance() isValid:record.IsDistanceValid()];
        self.elevation = [FitParser parseFloat:record.GetAltitude() isValid:record.IsAltitudeValid()];
        self.cadence = [FitParser parseInteger:record.GetCadence() isValid:record.IsCadenceValid()];
        self.heartrate = [FitParser parseInteger:record.GetHeartRate() isValid:record.IsHeartRateValid()];
        
        NSLog(@"➡️➡️➡️ Record %fl / %fl / %@ / %@l / %@ / %@ / %@",
              self.coordinate.latitude,
              self.coordinate.longitude,
              self.time,
              self.distance,
              self.elevation,
              self.cadence,
              self.heartrate);
    }
    return self;
}

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

@end
