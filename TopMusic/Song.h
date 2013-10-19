//
//  Song.h
//  TopMusic
//
//  Created by Tekhne on 10/19/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, strong) NSString *songName;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *album;
@property (nonatomic, strong) NSURL *artworkUrl30;
@property (nonatomic, strong) NSURL *artworkUrl100;
@property (nonatomic, strong) UIImage *artwork30;
@property (nonatomic, strong) UIImage *artwork100;
@property (nonatomic, strong) NSURL *previewSong;

@end
