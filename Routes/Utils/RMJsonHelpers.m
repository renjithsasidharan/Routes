//
//  RMJsonHelpers.m
//  Routes
//
//  Created by Renjith K Sasidharan on 27/12/13.
//  Copyright (c) 2012 Amphon. All rights reserved.
//

#import "RMJsonHelpers.h"

@implementation RMJsonHelpers

+(bool) getBoolFromDictionary:(NSDictionary*) dict forKey:(NSString*) key
{
    NSObject* obj = [dict objectForKey:key];
    if ([[obj class] isSubclassOfClass:[NSNumber class]])
        return [(NSNumber*)obj boolValue];
    
    if ([[obj class] isSubclassOfClass:[NSString class]])
        return [(NSString*)obj boolValue];
    
    return false;
}


+(float) getFloatFromDictionary:(NSDictionary*) dict forKey:(NSString*) key
{
    NSObject* obj = [dict objectForKey:key];
    if ([[obj class] isSubclassOfClass:[NSNumber class]])
        return [(NSNumber*)obj floatValue];
    
    if ([[obj class] isSubclassOfClass:[NSString class]])
    {
        return [(NSString*)obj floatValue];
    }
    return 0.0f;
}


+(NSInteger) getIntFromDictionary:(NSDictionary*) dict forKey:(NSString*) key
{
    NSObject* obj = [dict objectForKey:key];
    if ([[obj class] isSubclassOfClass:[NSNumber class]])
        return [(NSNumber*)obj integerValue];
    
    if ([[obj class] isSubclassOfClass:[NSString class]])
    {
        NSString* s = (NSString*)obj;
        if ([[s substringToIndex:2] isEqualToString:@"0x"])
        {
            NSScanner* scanner = [NSScanner scannerWithString:s];
            unsigned int iValue = 0;
            [scanner scanHexInt:&iValue];
            return iValue;
        }
        return [(NSString*)obj integerValue];
    }
    return NSNotFound;
}

+(NSDate*) getDateFromDictionary:(NSDictionary*) dict forKey:(NSString*) key
{
    NSObject* obj = [dict objectForKey:key];
    if ([[obj class] isSubclassOfClass:[NSString class]])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        
        NSDate* date = [dateFormatter dateFromString:[dict objectForKey:key]];
        if (date != nil)
            return date;
        
        dateFormatter.timeZone = [NSTimeZone localTimeZone];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.S";
        date = [dateFormatter dateFromString:[dict objectForKey:key]];
        if (date != nil)
            return date;
    }
    if ([[obj class] isSubclassOfClass:[NSNumber class]])
    {
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[(NSNumber*)obj doubleValue]];
        if (date != nil)
            return date;
    }
    return nil;
}

+(NSArray*) getArrayFromDictionary:(NSDictionary*) dict forKey:(NSString*) key
{
    NSArray* array = [dict objectForKey:key];
    if ([[array class] isSubclassOfClass:[NSArray class]])
        return array;
    return nil;
}

+(NSArray*) convertArrayofDictionary:(NSArray*) array toArrayofClass:(Class)valueClass
{
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    for (NSDictionary* item in (NSArray*)array)
    {
        id value = [[valueClass alloc] initWithDictionary:item];
        [(NSMutableArray*)returnArray addObject:value];
    }
    return returnArray;
}

+(NSDictionary*) convertArrayToKeyValuePairOfClass:(NSArray*) array forKey:(NSString*) key andClass:(Class)valueClass
{
    NSMutableDictionary* keyValueList = [[NSMutableDictionary alloc] init];
    for (NSDictionary* item in (NSArray*)array)
    {
        id value = [[valueClass alloc] initWithDictionary:item];
        [keyValueList setObject:value forKey:[item objectForKey:key]];
     }
    return keyValueList;
}

@end

