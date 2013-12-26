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

-(void) populateFromDictionary:(NSDictionary *)data {
    NSDictionary* startLocation =  data[@"start_location"];
    NSDictionary* endLocation   =  data[@"end_location"];
    _distance = data[@"distance"][@"value"];
    _startLatitude = startLocation[@"lat"];
    _startLongitude = startLocation[@"lng"];
    _endLatitude  = endLocation[@"lat"];
    _endLongitude = endLocation[@"lng"];
}

@end

@implementation RMRouteModel

- (void) populateFromDictionary:(NSDictionary *)data {
    _legs = [RMJsonHelpers convertArrayofDictionary:data[@"legs"] toArrayofClass:[RMRouteLegModel class]];
    _polyline = data[@"overview_polyline"][@"points"];
}

@end

@implementation RMDirectionModel

-(void) populateFromDictionary:(NSDictionary *)data {
    _routes = [RMJsonHelpers convertArrayofDictionary:data[@"routes"] toArrayofClass:[RMRouteModel class]];
    _status = data[@"status"];
}

@end
