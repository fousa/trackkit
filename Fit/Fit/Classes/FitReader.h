//
//  FitReader.h
//  Test
//
//  Created by Jelle Vandebeeck on 07/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FitRecord;

@interface FitReader : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<FitRecord *> *records;

- (instancetype)initWithPath:(NSString *)path;
- (void)read;

@end
