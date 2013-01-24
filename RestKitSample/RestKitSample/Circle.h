//
//  Circle.h
//  RestKitSample
//
//  Created by Apple on 13-1-23.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
#import "Favour.h"

@interface Circle : NSObject

@property (nonatomic, copy) NSString *circleId;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *picListStr;
@property (nonatomic, copy) NSDate *sendTime;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *sculpturePicUrl;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) int commentSize;

@property (nonatomic, copy) NSArray* commentList;
@property (nonatomic, copy) NSArray* favourList;

@end



