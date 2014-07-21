//
//  VJNetworkCommand.m
//  VideoFromJsonDemo
//
//  Created by Jiuzheng Chen on 7/21/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "VJNetworkCommand.h"

@implementation VJNetworkCommand

+ (void)retrieveVideoListJSONWithCompleteBlock:(NetworkCommandCompletionBlock)completeBlock
{
    NSString *requestPath = @"https://www.kamcord.com/api/ingameviewer/feed/?developer_key=665e00d21fb57dfe0714bbfc11df42a2&type=trending";
    NSURL *requestUrl = [NSURL URLWithString:requestPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSError *decodeError = nil;
        id result = nil;
        
        if (data)
        {
            result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&decodeError];
        }
        
        if ([result isKindOfClass:[NSArray class]])
        {
            result = @{@"response": result};
        }
        
        if (completeBlock)
        {
            if (connectionError || decodeError || !result)
            {
                completeBlock(NO, nil);
            }
            else
            {
                completeBlock(YES, result);
            }
        }
        
    }];
}

@end
