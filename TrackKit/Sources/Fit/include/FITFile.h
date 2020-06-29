//
//  FITFile.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FITActivity.h"
#import "FITCourse.h"

@interface FITFile : NSObject

@property (nonatomic, strong, nonnull) NSArray<FITActivity *> *activities;
@property (nonatomic, strong, nonnull) NSArray<FITCourse *> *courses;

@end
