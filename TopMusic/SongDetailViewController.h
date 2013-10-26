//
//  SongDetailViewController.h
//  TopMusic
//
//  Created by Tekhne on 10/26/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Song.h"

@interface SongDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgAlbun;
@property (weak, nonatomic) IBOutlet UILabel *lblArtistname;
@property (nonatomic, strong) Song *song;


- (IBAction)playSong:(id)sender;

@end
