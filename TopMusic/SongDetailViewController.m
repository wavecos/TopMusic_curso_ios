//
//  SongDetailViewController.m
//  TopMusic
//
//  Created by Tekhne on 10/26/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import "SongDetailViewController.h"

@interface SongDetailViewController ()

@end

@implementation SongDetailViewController

dispatch_queue_t myQueueImg100;
AVAudioPlayer *audioPlayer;


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
    
    self.title = self.song.songName;
    
    self.lblArtistname.text = self.song.artistName;
    
    myQueueImg100 = dispatch_queue_create("com.tekhne.TopMusic",  NULL);
    
    dispatch_async(myQueueImg100, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:self.song.artworkUrl100];
        
        self.song.artwork100 = [UIImage imageWithData:imgData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgAlbun.image = self.song.artwork100;
        });
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playSong:(id)sender {
    
    NSData *songData = [NSData dataWithContentsOfURL:self.song.previewSong];
 
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc] initWithData:songData error:&error];
    
    
    audioPlayer.numberOfLoops = 0;
    
    audioPlayer.volume = 1.0f;
    
    [audioPlayer prepareToPlay];
    
    if (audioPlayer == nil) {
        NSLog(@"Error : %@", error.description);
    } else {
        [audioPlayer play];
    }
}



@end
