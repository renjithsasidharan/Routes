//
//  RMResourceModel.m
//  Routes
//
//  Created by Renjith K Sasidharan on 26/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import "RMResourceModel.h"
#import "DDLog.h"

@implementation RMResourceModel

+ (void) createModelWithURL:(NSURL*)url completion:(void (^)(id , NSError *)) completion
{
    NSAssert(self != [RMResourceModel class],@"Model being created should be a subclass of MFResourceModel, not MFResourceModel itself");
}

+ (id) createModelWithJSON:(id) json
{
    NSAssert([self jsonIsValid:json], @"The server returned data that could not be parsed correctly");    
    RMResourceModel* model = [[self alloc] initWithDictionary:json];
    return model;
}

+ (BOOL) jsonIsValid:(NSDictionary*)json
{
    return YES;
}

- (id)initWithDictionary:(NSDictionary*) data
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

@end
