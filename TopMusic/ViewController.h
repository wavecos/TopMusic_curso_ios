//
//  ViewController.h
//  TopMusic
//
//  Created by Tekhne on 10/12/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
#import "SongCell.h"
#import "SongDetailViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UITableView *tblSongs;

@property (nonatomic, strong) NSMutableArray *songs;

- (IBAction)search:(id)sender;


@end
