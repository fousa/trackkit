//
//  FitParser.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "fit_date_time.hpp"

@interface FitParser : NSObject

+ (NSNumber *)parseInteger:(FIT_UINT8)value isValid:(FIT_BOOL)isValid;
+ (NSNumber *)parseFloat:(FIT_FLOAT32)value isValid:(FIT_BOOL)isValid;
+ (NSDate *)parseTimestamp:(FIT_DATE_TIME)value isValid:(FIT_BOOL)isValid;

@end
