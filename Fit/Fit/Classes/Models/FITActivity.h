//
//  FITActivity.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITLap.h"

#import <Foundation/Foundation.h>
#include <list>

#include "fit_record_mesg.hpp"
#include "fit_lap_mesg.hpp"

@interface FITActivity : NSObject

@property (nonatomic, strong, readonly) NSArray<FITLap *> *laps;

- (instancetype)initWithRecords:(std::list<fit::RecordMesg>)records
                           laps:(std::list<fit::LapMesg>)laps;

@end
