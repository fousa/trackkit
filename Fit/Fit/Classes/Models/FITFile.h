//
//  FITFile.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITActivity.h"

#import <Foundation/Foundation.h>
#include <list>

#include "fit_activity_mesg.hpp"
#include "fit_record_mesg.hpp"
#include "fit_lap_mesg.hpp"

@interface FITFile : NSObject

@property (nonatomic, strong, readonly) NSArray<FITActivity *> *activities;

- (instancetype)initWithActivities:(std::list<fit::ActivityMesg>)actities
                           records:(std::list<fit::RecordMesg>)records
                              laps:(std::list<fit::LapMesg>)laps;

@end
