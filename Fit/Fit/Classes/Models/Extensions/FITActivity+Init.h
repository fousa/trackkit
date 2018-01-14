//
//  FITActivity+Init.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>
 #include <list>

#import "FITActivity.h"

#include "fit_record_mesg.hpp"
#include "fit_lap_mesg.hpp"

@interface FITActivity (Init)

- (instancetype)initWithRecords:(std::list<fit::RecordMesg>)records
                           laps:(std::list<fit::LapMesg>)laps;

@end
