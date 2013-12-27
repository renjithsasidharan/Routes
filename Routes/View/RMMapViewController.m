//
//  RMMapViewController.m
//  Routes
//
//  Created by Renjith K Sasidharan on 21/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import "RMMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "RMDirectionService.h"
#import "RMDirectionModel.h"
#import "RMLocationMenuViewController.h"
#import <DDLog.h>

@interface RMMapViewController ()

@end

@implementation RMMapViewController

NSMutableArray* markers_;
NSMutableArray* polylines_;
UIBarButtonItem* routeButton_;
RMLocationMenuViewController* loctionMenuViewController_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadView
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                            longitude:0
                                                                 zoom:0];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.delegate = self;
    self.view =self.mapView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getDirections];
    
    routeButton_ = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Direction"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(locationMenuView)];
    self.navigationItem.rightBarButtonItem = routeButton_;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) locationMenuView
{
    loctionMenuViewController_ =  [[RMLocationMenuViewController alloc] init];
    [loctionMenuViewController_ presentPopoverFromBarButtonItem:routeButton_ permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void) getDirections {
    
    RMDirectionService* directionService =  [[RMDirectionService alloc] init];
    SEL selector = @selector(addDirectionsWithModel:);
    [directionService setDirectionsQuery:nil withSelector:selector withDelegate:self];
}

-(void) addDirectionsWithModel:(RMDirectionModel*) directionModel {
    
    NSString* status = directionModel.status;
    if([status isEqualToString:@"OK"]){
        RMRouteModel *routes =[[directionModel routes] objectAtIndex:0];
        NSString *route = [routes polyline];
        
        GMSPath *path = [GMSPath pathFromEncodedPath:route];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        
        polyline.strokeColor = [UIColor greenColor];
        polyline.strokeWidth = 07.f;
        polyline.geodesic = YES;
        polyline.map = self.mapView;
        [polylines_ addObject:polyline];
        
        NSArray *legs = [routes legs];
        UIColor *color = [UIColor  redColor];
        for(int i =0; i < [legs count]; i++) {
            RMRouteLegModel *leg = [legs objectAtIndex:i];
            NSString *latitude = [leg startLatitude];
            NSString *longitude = [leg startLongitude];
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
            
            GMSMarker *marker =  [GMSMarker markerWithPosition:position];
            marker.icon = [GMSMarker markerImageWithColor:color];
            marker.userData = nil;
            marker.map = self.mapView;
            [markers_ addObject:marker];
            color = [UIColor  grayColor];
        }
        RMRouteLegModel *leg = [legs lastObject];
        NSString *latitude = [leg endLatitude];
        NSString *longitude = [leg endLongitude];
        CLLocationCoordinate2D position =  CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
        
        GMSMarker *marker =  [GMSMarker markerWithPosition:position];
        color = [UIColor  greenColor];
        marker.icon = [GMSMarker markerImageWithColor:color];
        marker.userData = nil;
        marker.map = self.mapView;
        [markers_ addObject:marker];
        
        [self positionMap:path];
    } else
        NSLog(@"Could not fetch routes: %@", status);
}

-(void) positionMap:(GMSPath *) path {
    
    if (path) {
        GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithPath:path];
        
        GMSCameraUpdate *update = [GMSCameraUpdate  fitBounds:bounds withPadding:100.0f];
        [self.mapView moveCamera:update];
    }
    
    if(markers_) {
        CLLocationCoordinate2D myLocation = ((GMSMarker *)markers_.firstObject).position;
        GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:myLocation coordinate:myLocation];
        
        for (GMSMarker *marker in markers_)
            bounds = [bounds includingCoordinate:marker.position];
        
        [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:100.0f]];
    }
}


@end
