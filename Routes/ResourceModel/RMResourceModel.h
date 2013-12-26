//
//  RMResourceModel.h
//  Routes
//
//  Created by Renjith K Sasidharan on 26/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMResourceModel;

@interface RMResourceModel : NSObject

+ (BOOL) jsonIsValid:(NSDictionary*)json;
- (id)initWithDictionary:(NSDictionary*) data;

@end
