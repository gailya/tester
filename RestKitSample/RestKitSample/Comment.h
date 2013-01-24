//
//  Comment.h
//  RestKitSample
//
//  Created by Apple on 13-1-24.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, copy) NSString *commentId;
@property (nonatomic, copy) NSString *commentContent;
@property (nonatomic, copy) NSString *sculpturePicUrl;
@property (nonatomic, copy) NSDate *commentDate;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickname;

@end
