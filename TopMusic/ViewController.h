//
//  ViewController.h
//  TopMusic
//
//  Created by Tekhne on 10/12/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblSongs;

@property (nonatomic, strong) NSMutableArray *songs;

- (IBAction)search:(id)sender;


@end
