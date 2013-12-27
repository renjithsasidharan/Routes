//
//  RMLocationModel.h
//  Routes
//
//  Created by Renjith K Sasidharan on 27/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import "RMResourceModel.h"

@interface RMLocationModel : RMResourceModel

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* latitude;
@property (nonatomic, strong) NSString* longitude;

- (RMLocationModel*) initWithDictionary:(NSDictionary*) data;

@end
