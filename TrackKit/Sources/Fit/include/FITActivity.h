//
//  FITActivity.h
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FITLap.h"

@interface FITActivity : NSObject

@property (nonatomic, strong, nullable) NSArray<FITLap *> *laps;

@end
