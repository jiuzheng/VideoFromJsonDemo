//
//  VJObjectModel.m
//  VideoFromJsonDemo
//
//  Created by Jiuzheng Chen on 7/21/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "VJObjectModel.h"

@implementation VJObjectModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (self)
    {
        _videoURL           = dict[@"video_url"];
        _videoDescription   = dict[@"description"];
        _timeAdded          = [dict[@"added_at"] longLongValue];
        _title              = dict[@"title"];
        _thumbnailURL       = dict[@"thumbnail_url"];
    }
    
    return self;
}

@end
