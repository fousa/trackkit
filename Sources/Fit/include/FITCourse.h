//
//  FITCourse.h
//  Fit
//
//  Created by Jelle Vandebeeck on 14/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FITPoint.h"

@interface FITCourse : NSObject

@property (nonatomic, strong, nonnull) NSArray<FITPoint *> *points;

@end

