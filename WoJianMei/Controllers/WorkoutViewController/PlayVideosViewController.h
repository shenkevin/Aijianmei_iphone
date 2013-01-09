//
//  FirstViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayVideosViewController : UIViewController 
{

    NSString *categoryId;
    NSString *categoryName;
    
    MPMoviePlayerController *_theMovie;
    
    
   



   
}

@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *categoryId;
@property (nonatomic, retain) MPMoviePlayerController *theMovie;



- (void)clickSegControl:(id)sender;

- (void)didDetectDoubleTap:(UITapGestureRecognizer *)tap;


@end





