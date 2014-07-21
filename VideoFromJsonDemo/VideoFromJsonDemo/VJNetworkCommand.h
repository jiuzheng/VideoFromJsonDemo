//
//  VJNetworkCommand.h
//  VideoFromJsonDemo
//
//  Created by Jiuzheng Chen on 7/21/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkCommandCompletionBlock)(BOOL success, NSDictionary *response);

@interface VJNetworkCommand : NSObject

+ (void)retrieveVideoListJSONWithCompleteBlock:(NetworkCommandCompletionBlock) completeBlock;

@end
