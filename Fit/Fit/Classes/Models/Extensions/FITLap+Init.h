//
//  FITLap+Init.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <list>

#import "FITLap.h"

#include "fit_record_mesg.hpp"
#include "fit_lap_mesg.hpp"

@interface FITLap (Init)

- (instancetype)initFromRecords:(std::list<fit::RecordMesg>)records;
- (instancetype)initFromLap:(fit::LapMesg)lap
                    records:(std::list<fit::RecordMesg>)records;

@end
