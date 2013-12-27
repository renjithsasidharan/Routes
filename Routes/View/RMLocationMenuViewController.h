//
//  RMRouteMenuViewController.h
//  Routes
//
//  Created by Renjith K Sasidharan on 27/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMLocationMenuViewController : UIPopoverController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableViewController * menuList;

@end
