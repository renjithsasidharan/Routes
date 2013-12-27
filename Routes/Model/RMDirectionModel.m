//
//  RMDirectionModel.m
//  Routes
//
//  Created by Renjith K Sasidharan on 22/10/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import "RMDirectionModel.h"
#import "RMJsonHelpers.h"
#import "RMResourceModel.h"


@implementation RMRouteLegModel

-(RMRouteLegModel*) initWithDictionary:(NSDictionary *)data {
    
    self = [super init];
    if(self) {
        NSDictionary* startLocation =  data[@"start_location"];
        NSDictionary* endLocation   =  data[@"end_location"];
        _distance = data[@"distance"][@"value"];
        _startLatitude = startLocation[@"lat"];
        _startLongitude = startLocation[@"lng"];
        _endLatitude  = endLocation[@"lat"];
        _endLongitude = endLocation[@"lng"];
    }
    
    return self;
}

@end

@implementation RMRouteModel

- (RMRouteModel*) initWithDictionary:(NSDictionary *)data {
    
    self = [super init];
    if (self)
    {
        _legs = [RMJsonHelpers convertArrayofDictionary:data[@"legs"] toArrayofClass:[RMRouteLegModel class]];
        _polyline = data[@"overview_polyline"][@"points"];
    }
    
    return self;
}

@end

@implementation RMDirectionModel

-(RMDirectionModel*) initWithDictionary:(NSDictionary *)data {
    
    self = [super init];
    if(self) {
        _routes = [RMJsonHelpers convertArrayofDictionary:data[@"routes"] toArrayofClass:[RMRouteModel class]];
        _status = data[@"status"];
    }
    
    return self;
}

@end
