//
//  FitParser.m
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FitParser.h"

#import <CoreLocation/CoreLocation.h>

@implementation FitParser

+ (NSNumber *)parseInteger:(FIT_UINT8)value isValid:(FIT_BOOL)isValid {
    if (!isValid) { return nil; }
    return [NSNumber numberWithInteger:value];
}

+ (NSNumber *)parseFloat:(FIT_FLOAT32)value isValid:(FIT_BOOL)isValid {
    if (!isValid) { return nil; }
    return [NSNumber numberWithFloat:value];
}

+ (NSDate *)parseTimestamp:(FIT_DATE_TIME)value isValid:(FIT_BOOL)isValid {
    if (!isValid) { return nil; }
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [components setCalendar:calendar];
    [components setTimeZone:[[NSTimeZone alloc] initWithName:@"GMT"]];
    [components setYear:1989];
    [components setMonth:12];
    [components setDay:31];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *fit_ref_date = [[components date] copy];
    return [NSDate dateWithTimeInterval:value sinceDate:fit_ref_date];
}

@end
