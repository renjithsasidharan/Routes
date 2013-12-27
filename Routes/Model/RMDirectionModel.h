//
//  RMDirectionModel.h
//  Routes
//
//  Created by Renjith K Sasidharan on 22/10/13.
//  Copyright (c) 2013 Amphon All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "RMResourceModel.h"


@interface RMRouteLegModel : RMResourceModel

@property (nonatomic, strong) NSString* distance;
@property (nonatomic, strong) NSString* startLatitude;
@property (nonatomic, strong) NSString* startLongitude;
@property (nonatomic, strong) NSString* endLatitude;
@property (nonatomic, strong) NSString* endLongitude;

-(RMRouteLegModel*) initWithDictionary: (NSDictionary*) data;

@end

@interface RMRouteModel : RMResourceModel

@property (nonatomic, strong) NSArray* legs;
@property (nonatomic, strong) NSString* polyline;

-(RMRouteModel*) initWithDictionary: (NSDictionary*) data;

@end

@interface RMDirectionModel : RMResourceModel

@property (nonatomic, strong) NSArray* routes;
@property (nonatomic, strong) NSString* status;

-(RMResourceModel*) initWithDictionary: (NSDictionary*) data;

@end
