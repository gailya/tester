//
//  ViewController.h
//  RestKitSample
//
//  Created by Apple on 13-1-23.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_circles;
}

@end
