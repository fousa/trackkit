//
//  FitReader.m
//  Test
//
//  Created by Jelle Vandebeeck on 07/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FitReader.h"
#import "FITActivity.h"

#include <fstream>
#include <iostream>
#include <iosfwd>

#include "fit_decode.hpp"
#include "fit_mesg_broadcaster.hpp"

#include "Listener.cpp"

@interface FitReader ()

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) FITFile *file;

@end

@implementation FitReader

#pragma mark - Init

- (instancetype)initWithData:(NSData *)data {
    if (self = [super init]) {
        self.data = data;
    }
    return self;
}

#pragma mark - Read

- (void)read {
    // Set the filepath.
    NSString *filename = [NSString stringWithFormat:@"%@.%@", [[NSProcessInfo processInfo] globallyUniqueString], @"fit"];
    NSURL *fileURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:filename]];
    self.path = [fileURL path];
    
    // Write the data to a temporary file.
    NSError *error = nil;
    [self.data writeToURL:fileURL options:NULL error:&error];
    
    // Try to open the file.
    fit::Decode decode;
    std::fstream file;
    file.open([self.path UTF8String], std::ios::in | std::ios::binary);
    if (!file.is_open()) { NSLog(@"🔥 Error opening file"); }
    if (!decode.IsFIT(file)) { NSLog(@"🔥 FIT check failed"); }
    if (!decode.CheckIntegrity(file)) { NSLog(@"🔥 Integrity check failed"); }

    // Setup the listeners.
    Listener listener;
    fit::MesgBroadcaster broadcaster = fit::MesgBroadcaster();
    broadcaster.AddListener((fit::ActivityMesgListener &)listener);
    broadcaster.AddListener((fit::RecordMesgListener &)listener);
    broadcaster.AddListener((fit::LapMesgListener &)listener);
    @try {
        NSLog(@"📦 Start listening file");
        decode.Read(file, broadcaster);
    }
    @catch (NSException *exception) {
        NSLog(@"🔥 Error decoding file %@", [exception reason]);
    }
    @finally {
        self.file = [[FITFile alloc] initWithActivities:listener.activities
                                                records:listener.records
                                                   laps:listener.laps];
//        double conversion = 180.0 / pow(2, 31);
//        for (fit::RecordMesg rawRecord : rawRecords) {
//            FitRecord *record = [FitRecord new];
//
//            ::fit::int32_t rawLatitude = rawRecord.GetPositionLat();
//            double convertedLatitude = rawLatitude * conversion;
//
//            ::fit::int32_t rawLongitude = rawRecord.GetPositionLong();
//            double convertedLongitude = rawLongitude * conversion;
//
//            record.coordinate = CLLocationCoordinate2DMake(convertedLatitude, convertedLongitude);
//            [self.records addObject:record];
//        }
        
//        NSLog(@"📦 Record count %lu", (unsigned long)[self.records count]);
//        NSLog(@"📦 Finished decoding file");
    }
}

@end
