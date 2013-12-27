//
//  RMDirectionService.m
//  Routes
//
//  Created by Renjith K Sasidharan on 26/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import "RMDirectionService.h"
#import "RMDirectionModel.h"

@implementation RMDirectionService

static NSString *gogoleDirectionsURL = @"http://maps.googleapis.com/maps/api/directions/json?";
NSMutableData *receivedData_;
NSURLConnection *connection_;
SEL selector_;
id delegate_;

- (void)setDirectionsQuery:(NSDictionary *)query
              withSelector:(SEL)selector
              withDelegate:(id)delegate{
    
    NSURL *directionsURL;
    NSArray *waypoints = [query objectForKey:@"waypoints"];
    NSString *origin = [waypoints objectAtIndex:0];
    int waypointCount = [waypoints count];
    int destinationPos = waypointCount -1;
    NSString *destination = [waypoints objectAtIndex:destinationPos];
    NSMutableString *url =
    [NSMutableString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=%@",
     gogoleDirectionsURL,origin,destination, @"false"];
    if(waypointCount>2) {
        [url appendString:@"&waypoints=optimize:false"];
        int wpCount = waypointCount-2;
        for(int i=1;i<=wpCount;i++){
            [url appendString: @"|"];
            [url appendString:[waypoints objectAtIndex:i]];
        }
    }
    url = [url stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    url = @"http://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&sensor=false";
    NSLog(@"URL: %@", url);
    directionsURL = [NSURL URLWithString:url];
    [self retrieveDirectionsWithURL:directionsURL withDelegate:delegate withSelector:selector];
}

- (void)retrieveDirectionsWithURL:(NSURL*) url
                     withDelegate:(id)delegate
                     withSelector:(SEL)selector{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        delegate_ = delegate;
        selector_ = selector;
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:60.0];
        receivedData_  = [NSMutableData dataWithCapacity:0];
        connection_ = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        if(!connection_) {
            receivedData_ = nil;
            UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Connection failed" message:@"Please check your network connectivity" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [theAlert show];
        }
        
    });
    
}

#pragma mark Delegate for NSURLConncetion

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    [receivedData_ setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    [receivedData_ appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // Release the connection and the data object to nil.
    connection_ = nil;
    receivedData_ = nil;
    
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData_ length]);
    NSLog(@"With contents: %@", [[NSString alloc] initWithData:receivedData_ encoding:NSASCIIStringEncoding]);
    RMDirectionModel* directionModel = [[RMDirectionModel alloc] init];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receivedData_ options:0 error:nil];

    // Release the connection and the data object
    connection_ = nil;
    receivedData_ = nil;
    
    IMP imp = [delegate_ methodForSelector:selector_];
    void (*func)(id, SEL, RMDirectionModel*) = (void *)imp;
    func(delegate_, selector_, [directionModel initWithDictionary:(NSDictionary*) dict]);
}

@end
