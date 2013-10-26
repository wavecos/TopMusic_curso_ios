//
//  ViewController.m
//  TopMusic
//
//  Created by Tekhne on 10/12/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

dispatch_queue_t myQueue;
dispatch_queue_t myQueueImg;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.txtSearch.delegate = self;
    
    self.songs = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma march Search Methods
- (IBAction)search:(id)sender {
    
    [self.txtSearch resignFirstResponder];
    
    myQueue = dispatch_queue_create("com.tekhne.TopMusic", NULL);
    
    dispatch_async(myQueue, ^{
        [self performSearch];
    });
}


-(void) performSearch {
    NSLog(@"... Conectando al servicio de itunes...");
    
    NSString *searchCriteria = [self.txtSearch.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *urlString = [[NSMutableString alloc] init];
    
    [urlString appendFormat:@"https://itunes.apple.com/search?term=%@", searchCriteria];
    [urlString appendString:@"&entity=song&limit=20"];
    
    NSLog(@"url formado : %@", urlString);
    
    
    //NSString *urlString = @"https://itunes.apple.com/search?term=beatles&entity=song&limit=20";
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(@"num de resultados: %@", [response objectForKey:@"resultCount"]);
    
    NSArray *songsFromJSON = [response objectForKey:@"results"];
    
    self.songs = [[NSMutableArray alloc] init];
    
    // Iteramos el resultado Json y lo colocamos en el array de Songs (Modelo)
    for (NSDictionary *songDic in songsFromJSON) {
        Song *song = [[Song alloc] init];
        [song setSongName:[songDic objectForKey:@"trackName"]];
        [song setArtistName:[songDic objectForKey:@"artistName"]];
        [song setAlbum:[songDic objectForKey:@"collectionName"]];
        
        NSString *url30 = [songDic objectForKey:@"artworkUrl30"];
        [song setArtworkUrl30:[NSURL URLWithString:url30]];
        
        NSString *url100 = [songDic objectForKey:@"artworkUrl100"];
        [song setArtworkUrl100:[NSURL URLWithString:url100]];

        NSString *urlPreviewSong = [songDic objectForKey:@"previewUrl"];
        [song setPreviewSong:[NSURL URLWithString:urlPreviewSong]];

        
        [self.songs addObject:song];
        
        // Colocamos las imagenes a Song (Modelo)
        myQueueImg = dispatch_queue_create("com.tekhne.TopMusicImg", NULL);
        dispatch_async(myQueueImg, ^{
            NSData *imgData30 = [NSData dataWithContentsOfURL:song.artworkUrl30];
            UIImage *img30 = [UIImage imageWithData:imgData30];
            
            [song setArtwork30:img30];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *index = [NSIndexPath indexPathForRow:[self.songs indexOfObject:song] inSection:0];

                [self.tblSongs reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            });
            
        });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tblSongs reloadData];
    });
}


#pragma mark TableView Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.songs count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"ESTOY PINTANDO LA CELDA");
    
    SongCell *cell =[tableView dequeueReusableCellWithIdentifier:@"songCell" forIndexPath:indexPath];
    
    // Esta es la forma anterior de Obtener una Celda
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"songCell"];
    
    Song *song = [self.songs objectAtIndex:indexPath.row];
    
    NSMutableString *detalle = [NSMutableString string];
    
    [detalle appendString:song.artistName];
    [detalle appendString:@" - "];
    [detalle appendString:song.album];
    
    cell.lblSongName.text = song.songName;
    cell.lblArtistName.text = detalle;
    cell.imgAlbum.image = song.artwork30;
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"SongDetail"] ) {
        
        SongDetailViewController *sdc = [segue destinationViewController];
        
        NSIndexPath *idx = [self.tblSongs indexPathForSelectedRow];
        
        Song *song = [self.songs objectAtIndex:idx.row];

        sdc.song = song;
    }
    
    
}






@end
