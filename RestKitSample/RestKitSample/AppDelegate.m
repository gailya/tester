//
//  AppDelegate.m
//  RestKitSample
//
//  Created by Apple on 13-1-23.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "AppDelegate.h"

#import <RestKit/RestKit.h>
#import "Circle.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    //let AFNetworking manage the activity indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Initialize HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://192.168.2.113:8088"];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    //we want to work with JSON-Data
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    client.parameterEncoding = AFJSONParameterEncoding;
    
    // Initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // Setup our object mappings
    RKObjectMapping *circleMapping = [RKObjectMapping mappingForClass:[Circle class]];
    [circleMapping addAttributeMappingsFromDictionary:@{
     @"id" : @"circleId",
     @"message" : @"message",
     @"picListStr" : @"picListStr",
     @"sendTime" : @"sendTime",
     @"userId" : @"userId",
     @"sculpturePicUrl" : @"sculpturePicUrl",
     @"nickname" : @"nickname",
     @"commentSize" : @"commentSize"
     }];
    
    
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[Comment class]];
    [commentMapping addAttributeMappingsFromArray:@[@"commentId", @"commentContent",@"sculpturePicUrl",@"commentDate",@"userId",@"nickname"]];
    
    RKObjectMapping *favourMapping = [RKObjectMapping mappingForClass:[Favour class]];
    [favourMapping addAttributeMappingsFromArray:@[@"userId",@"nickname"]];
    
    RKRelationshipMapping* commentRelationShipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"commentList"
                                                                                             toKeyPath:@"commentList"
                                                                                           withMapping:commentMapping];
    RKRelationshipMapping* favourRelationShipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"favourList"
                                                                                                    toKeyPath:@"favourList"
                                                                                                  withMapping:favourMapping];
    [circleMapping addPropertyMapping:commentRelationShipMapping];
    [circleMapping addPropertyMapping:favourRelationShipMapping];
    

    
    // Register our mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:circleMapping
                                                                                       pathPattern:@"/centa-web/Services/Action/FriendCircleAction/GetCircleList"
                                                                                           keyPath:@"payload"
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    // Create Window and View Controllers
    ViewController *viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
