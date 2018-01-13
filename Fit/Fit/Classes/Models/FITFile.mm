//
//  FITFile.m
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITFile.h"

@interface FITFile ()

@property (nonatomic, strong) NSArray<FITActivity *> *activities;

@end

@implementation FITFile

#pragma mark - Init

- (instancetype)initWithActivities:(std::list<fit::ActivityMesg>)actities
                           records:(std::list<fit::RecordMesg>)records
                              laps:(std::list<fit::LapMesg>)laps {
    if (self = [super init]) {
        FITActivity *activity = [[FITActivity alloc] initWithRecords:records laps:laps];
        self.activities = [NSArray arrayWithObject:activity];
    }
    return self;
}

@end
