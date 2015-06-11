//
//  DetailViewController.m
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import "DetailViewController.h"
#import "PhotoViewController.h"
#import "appDelegate.h"
#import "Photo.h"
#import "PhotoCell.h"
#import "ImageManager.h"
#import "ImageViewController.h"
#import <CoreData/CoreData.h>

@interface DetailViewController ()

@property NSArray * photos;
@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.photos = [Photo getPhotosByBus:self.bus.line];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCamera"]) {

        PhotoViewController *destViewController = segue.destinationViewController;
       
        destViewController.bus = self.bus;
    }
    
    else if ([[segue identifier] isEqualToString:@"showImage"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ImageViewController * destinationViewController = segue.destinationViewController;
        Photo * myPhoto = [self.photos objectAtIndex:indexPath.row];
        destinationViewController.image = myPhoto;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell"];
    Photo *myPicture = self.photos[indexPath.row];
    cell.TitleLabel.text = myPicture.name;
    
    NSString *imgName = [NSString stringWithFormat:@"%@.png", myPicture.name];
    UIImage * myImg = [ImageManager loadImage:imgName];
    cell.image.image = myImg;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MM yyyy HH:mm"];
    NSString *stringFromDate = [formatter stringFromDate:myPicture.date];
    cell.dateLabel.text = stringFromDate;
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Photo * photoToDelete = self.photos[indexPath.row];
        NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        [context deleteObject:photoToDelete];
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
        
        self.photos = [Photo getPhotosByBus:self.bus.line];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [ImageManager deleteImage:photoToDelete.name];
        
     
        }
}

@end
