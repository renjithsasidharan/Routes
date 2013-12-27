//
//  RMAppDelegate.h
//  Routes
//
//  Created by Renjith K Sasidharan on 21/12/13.
//  Copyright (c) 2013 Amphon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UINavigationController *navController;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
