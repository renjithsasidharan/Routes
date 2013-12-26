//
//  RMDirectionService.h
//  Routes
//
//  Created by Renjith K Sasidharan on 26/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMDirectionService : NSObject

- (void)setDirectionsQuery:(NSDictionary *)object withSelector:(SEL)selector withDelegate:(id)delegate;

@end
