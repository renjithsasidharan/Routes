//
//  RMLocationModel.m
//  Routes
//
//  Created by Renjith K Sasidharan on 27/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import "RMLocationModel.h"

@implementation RMLocationModel

-(id) init {
    self  = [super init];
    if(self) {
        _name = nil;
        _latitude =  nil;
        _longitude = nil;
    }
    return self;
}

-(RMLocationModel*) initWithDictionary:(NSDictionary *)data {
    
    self = [super initWithDictionary:data];
    if(self) {
        _name = nil;
        _latitude =  nil;
        _longitude = nil;
    }
    return  self;
}

@end
