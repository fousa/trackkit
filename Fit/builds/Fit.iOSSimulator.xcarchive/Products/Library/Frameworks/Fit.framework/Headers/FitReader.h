//
//  FitReader.h
//  Test
//
//  Created by Jelle Vandebeeck on 07/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FITFile.h"

extern BOOL const kEnableLogging;

@interface FitReader : NSObject

@property (nonatomic, strong, readonly) FITFile *file;

- (instancetype)initWithData:(NSData *)data;
- (void)read;

@end
