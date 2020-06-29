//
//  FITPoint.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FITPoint : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, nullable) NSNumber *elevation;
@property (nonatomic, strong, nullable) NSNumber *distance;
@property (nonatomic, strong, nullable) NSNumber *heartrate;
@property (nonatomic, strong, nullable) NSNumber *cadence;
@property (nonatomic, strong, nullable) NSDate *time;

@end
