//
//  FITFile+Init.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <list>

#import "FITFile.h"

#include "fit_activity_mesg.hpp"
#include "fit_record_mesg.hpp"
#include "fit_lap_mesg.hpp"
#include "fit_segment_point_mesg.hpp"

@interface FITFile (Init)

- (instancetype)initWithActivities:(std::list<fit::ActivityMesg>)actities
                           records:(std::list<fit::RecordMesg>)records
                              laps:(std::list<fit::LapMesg>)laps
                     segmentPoints:(std::list<fit::SegmentPointMesg>)segmentPoints;

@end
