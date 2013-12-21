//
//  RMMapViewController.h
//  Routes
//
//  Created by Renjith K Sasidharan on 21/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface RMMapViewController : UIViewController <GMSMapViewDelegate>

@property (strong, nonatomic) GMSMapView *mapView;

@end
