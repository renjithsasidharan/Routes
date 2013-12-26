//
//  RMJsonHelpers.h
//  Routes
//
//  Created by Renjith K Sasidharan on 26/12/13.
//  Copyright (c) 2012 Amphon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface RMJsonHelpers : NSObject

+ (bool)        getBoolFromDictionary:(NSDictionary*) dict forKey:(NSString*) key;
+ (NSInteger)   getIntFromDictionary:(NSDictionary*) dict forKey:(NSString*) key;
+ (NSDate*)     getDateFromDictionary:(NSDictionary*) dict forKey:(NSString*) key;
+ (NSArray*)    getArrayFromDictionary:(NSDictionary*) dict forKey:(NSString*) key;
+ (NSDictionary*) convertArrayToKeyValuePairOfClass:(NSArray*) array forKey:(NSString*) key andClass:(Class)valueClass;
+ (NSArray*)    convertArrayofDictionary:(NSArray*) array toArrayofClass:(Class)valueClass;
+(float)        getFloatFromDictionary:(NSDictionary*) dict forKey:(NSString*) key;

@end

