//
//  FitReader.h
//  Test
//
//  Created by Jelle Vandebeeck on 07/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitReader : NSObject

- (instancetype)initWithPath:(NSString *)path;
- (void)read;

@end
