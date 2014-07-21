//
//  VJObjectModel.h
//  VideoFromJsonDemo
//
//  Created by Jiuzheng Chen on 7/21/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VJObjectModel : NSObject

@property (nonatomic, strong) NSNumber      * score;
@property (nonatomic, strong) NSString      * videoURL;
@property (nonatomic, strong) NSNumber      * level;
@property (nonatomic, strong) NSString      * appName;
@property (nonatomic, strong) NSString      * videoDescription;
@property (nonatomic, strong) NSNumber      * appId;
@property (nonatomic, assign) NSTimeInterval  timeAdded;
@property (nonatomic, strong) NSString      * title;
@property (nonatomic, strong) NSString      * thumbnailURL;
@property (nonatomic, strong) NSString      * videoId;
@property (nonatomic, strong) NSString      * appStoreURL;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
