//
//  ViewController.m
//  VideoFromJsonDemo
//
//  Created by Jiuzheng Chen on 7/21/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "VJMainViewController.h"
#import "VJNetworkCommand.h"
#import "VJObjectModel.h"
#import "VJTableViewCell.h"
#import "VJWebViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VJMainViewController ()

// If we have multiple places that might use the same array, I would put it in a sharedInstance.
@property (nonatomic, strong) NSArray * videoList;
@property (nonatomic, strong) MPMoviePlayerViewController * moviePlayer;

@end

@implementation VJMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [VJNetworkCommand retrieveVideoListJSONWithCompleteBlock:^(BOOL success, NSDictionary *response) {
        if (success)
        {
            NSMutableArray * mutableVideoList = [[NSMutableArray alloc] init];
            NSArray * jsonList = response[@"response"];
            for (NSDictionary * dict in jsonList)
            {
                VJObjectModel * vjObject = [[VJObjectModel alloc] initWithDictionary:dict];
                [mutableVideoList addObject:vjObject];
            }
            
            self.videoList = mutableVideoList;
            
            [self.tableView reloadData];
        }
        else
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Connection Failure" message:@"Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.videoList.count;
}

- (VJTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * cellID = @"VideoCellID";
  	VJTableViewCell * cell = (VJTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    // Get the specific VJObjectModel
    VJObjectModel * vjObject = self.videoList[indexPath.row];
    
    [cell configureWithVJObject:vjObject];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    // go to URL
    VJObjectModel * vjObject = self.videoList[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:vjObject.videoURL];
    self.moviePlayer = [[MPMoviePlayerViewController alloc] init];
    
    [self.moviePlayer.moviePlayer prepareToPlay];
    [self.moviePlayer.moviePlayer.view setFrame: self.view.bounds];
    self.moviePlayer.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    self.moviePlayer.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
    self.moviePlayer.moviePlayer.contentURL = url;
    [self.moviePlayer.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self presentMoviePlayerViewControllerAnimated:self.moviePlayer];
    self.moviePlayer.moviePlayer.shouldAutoplay = YES;
    [self.moviePlayer.moviePlayer play];
}

@end
