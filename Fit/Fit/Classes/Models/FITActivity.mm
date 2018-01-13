//
//  FITActivity.m
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITActivity.h"

@interface FITActivity ()

@property (nonatomic, strong) NSArray<FITLap *> *laps;

@end

@implementation FITActivity

#pragma mark - Init

- (instancetype)initWithRecords:(std::list<fit::RecordMesg>)rawRecords
                           laps:(std::list<fit::LapMesg>)laps {
    if (self = [super init]) {
            FIT_DATE_TIME previousTimestamp = 0;
            for (fit::LapMesg rawLap : laps) {
                FIT_DATE_TIME lapTimestamp = rawLap.GetTimestamp();
                
                std::list<fit::RecordMesg> records;
                for (fit::RecordMesg record : rawRecords) {
                    FIT_DATE_TIME timestamp = record.GetTimestamp();
                    if (timestamp > previousTimestamp && timestamp <= lapTimestamp) {
                        records.push_front(record);
                    }
                }
                
                FITLap *lap = [[FITLap alloc] initFromLap:rawLap records:records];
                self.laps = [NSArray arrayWithObject:lap];
                
                previousTimestamp = lapTimestamp;
            }
    }
    return self;
}

@end
