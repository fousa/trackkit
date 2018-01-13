//
//  FITActivity+Init.m
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITActivity+Init.h"
#import "FITLap+Init.h"

@implementation FITActivity (Init)

- (instancetype)initWithRecords:(std::list<fit::RecordMesg>)rawRecords
                           laps:(std::list<fit::LapMesg>)rawLaps {
    if (self = [super init]) {
        NSMutableArray *laps = [NSMutableArray array];
        FIT_DATE_TIME previousTimestamp = 0;
        for (fit::LapMesg rawLap : rawLaps) {
            FIT_DATE_TIME lapTimestamp = rawLap.GetTimestamp();
            
            std::list<fit::RecordMesg> records;
            for (fit::RecordMesg record : rawRecords) {
                FIT_DATE_TIME timestamp = record.GetTimestamp();
                if (timestamp > previousTimestamp && timestamp <= lapTimestamp) {
                    records.push_front(record);
                }
            }
            
            FITLap *lap = [[FITLap alloc] initFromLap:rawLap records:records];
            [laps addObject:lap];
            
            previousTimestamp = lapTimestamp;
        }
        
        if ([laps count] > 0) {
            self.laps = laps;
        }
    }
    return self;
}

@end
