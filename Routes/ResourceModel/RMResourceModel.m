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
    
//    [[MFHTTPClient sharedClient] getPath:[url absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id json) {
//        
//        if ([self jsonIsValid:json])
//        {
//            MFResourceModel* model = [[self alloc] initWithDictionary:json];
//            completion(model, nil);
//        }
//        else
//        {
//            NSDictionary* info = @{NSLocalizedDescriptionKey: @"The server returned data that could not be parsed correctly"};
//            NSError* error = [NSError errorWithDomain:@"com.google" code:0 userInfo:info];
//            completion(nil,error);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        completion(nil,error);
//    }];
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
//        id links = data[@"links"];
//        if(links)
//            _links = [MFLink linksArrayFromArrayOfDictionaries:links];
    }
    return self;
}

@end
