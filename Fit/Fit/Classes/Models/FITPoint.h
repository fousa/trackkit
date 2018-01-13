//
//  FITPoint.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#include <list>

#include "fit_record_mesg.hpp"

@interface FITPoint : NSObject

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, readonly) NSNumber *elevation;
@property (nonatomic, strong, readonly) NSNumber *distance;
@property (nonatomic, strong, readonly) NSNumber *heartrate;
@property (nonatomic, strong, readonly) NSNumber *cadence;
@property (nonatomic, strong, readonly) NSDate *time;

- (instancetype)initWithRecord:(fit::RecordMesg)record;

@end
