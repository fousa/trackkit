//
//  FITCourse+Init.h
//  Fit
//
//  Created by Jelle Vandebeeck on 14/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <list>

#import "FITCourse.h"

#include "fit_segment_point_mesg.hpp"

@interface FITCourse (Init)

- (instancetype)initWithSegmentPoints:(std::list<fit::SegmentPointMesg>)segmentPoints;

@end

