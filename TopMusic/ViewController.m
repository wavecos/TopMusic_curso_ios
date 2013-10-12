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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma march Search Methods
- (IBAction)search:(id)sender {
    
    NSLog(@"... Conectando al servicio de itunes...");
    
    NSString *urlString = @"https://itunes.apple.com/search?term=beatles&entity=song&limit=20";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //NSLog(@"recibido de itunes : %@", response);
    
    NSLog(@"num de resultados: %@", [response objectForKey:@"resultCount"]);
    
    self.songs = [response objectForKey:@"results"];
    
    [self.tblSongs reloadData];
    
}

#pragma mark TableView Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.songs count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"songCell"];
    
    NSDictionary *song = [self.songs objectAtIndex:indexPath.row];
    
    
    
    NSMutableString *detalle = [NSMutableString string];
    
    [detalle appendString:[song objectForKey:@"artistName"]];
    [detalle appendString:@" - "];
    [detalle appendString:[song objectForKey:@"collectionName"]];
    
    // TODO resolver y tratar las imagenes en hilos!
//    NSURL *urlImage = [song objectForKey:@"artworkUrl30"];
//    NSData *dataImage = [NSData dataWithContentsOfURL:urlImage options:kNilOptions error:nil];
//    
//    UIImage *songImage = [UIImage imageWithData:dataImage];
    
    cell.textLabel.text = [song objectForKey:@"trackName"];
    cell.detailTextLabel.text = detalle;
    //cell.imageView.image = songImage;
    
    return cell;
    
}




@end
