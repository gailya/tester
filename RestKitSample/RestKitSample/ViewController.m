//
//  ViewController.m
//  RestKitSample
//
//  Created by Apple on 13-1-23.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "Circle.h"
#import <Restkit/RestKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadCirle
{
    // Load the object model via RestKit
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSDictionary *dict = @{@"requestId": @"GetCircleList",
    @"sessionId":@"SSSSSSSSSSSSSSSSSSSS",
    @"userName":@"mobile2",
    @"password":@"BBBbbb222",
    @"request":@{
    @"start":@"1",
    @"limit":@"5",
    @"typeId":@"1",
    @"userId":@"402882e93c5c2290013c5c2293590000",
    @"commentStart":@"1",@"commentLimit":@"10"}
    };
    
    
    [objectManager postObject:nil
                         path:@"/centa-web/Services/Action/FriendCircleAction/GetCircleList"
                         parameters:dict
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                NSArray* circles = [mappingResult array];
                                NSLog(@"Loaded statuses: %@", circles);
                                _circles = circles;
                                if(self.isViewLoaded)
                                    [_tableView reloadData];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                message:[error localizedDescription]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil];
                                [alert show];
                                NSLog(@"Hit error: %@", error);
                            }];

}

-(void)loadView
{
    [super loadView];
    
    // Setup View and Table View
    self.title = @"RestKit Sample";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadCirle)];
    
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/blog/developer/wiki/LOGO_32x32.png"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logoView];

    [logoView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo"]];
    //[logoView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"logo"] success:nil failure:nil];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG.png"]];
    imageView.frame = CGRectOffset(imageView.frame, 0, -64);
    
    [self.view insertSubview:imageView atIndex:0];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    [self loadCirle];
}

- (NSString *)getDisplayText:(Circle *)circle
{
    NSString *displayText = [NSString stringWithFormat:@"%@ posts: %@", circle.nickname, circle.message];
    for (Comment *comment in circle.commentList) {
        NSString *commentText = [NSString stringWithFormat:@"%@ comments: %@", comment.nickname, comment.commentContent];
        displayText = [NSString stringWithFormat:@"%@\n  %@", displayText, commentText];
    }
    for (Favour *favour in circle.favourList) {
        NSString *favourText = [NSString stringWithFormat:@"%@ liked this circle", favour.nickname];
        displayText = [NSString stringWithFormat:@"%@\n  %@", displayText, favourText];
    }
    return displayText;
}


#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Circle *circle = [_circles objectAtIndex:indexPath.row];
    NSString *displayText = [self getDisplayText:circle];
    CGSize size = [displayText sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(300, 9000)];
    return size.height + 30;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [_circles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"Circle Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];
    }
    Circle* circle = [_circles objectAtIndex:indexPath.row];
    cell.textLabel.text = [self getDisplayText:circle];
    cell.detailTextLabel.text = [circle.sendTime description];
    return cell;
}


@end
