//
//  FITPoint+Init.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FitPoint.h"

#include "fit_record_mesg.hpp"

@interface FITPoint (Init)

- (instancetype)initWithRecord:(fit::RecordMesg)record;

@end
