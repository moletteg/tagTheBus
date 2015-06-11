//
//  ImageViewController.m
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import "ImageViewController.h"
#import <UIKit/UIKit.h>
#import "ImageManager.h"

@interface ImageViewController ()

@property UIImage *displayedImage;

@end

@implementation ImageViewController


-(void)viewDidLoad {
    
    NSString *imgName = [NSString stringWithFormat:@"%@.png", self.image.name];
    self.displayedImage = [ImageManager loadImage:imgName];
    self.imageView.image = self.displayedImage;
    self.title = self.image.name;
}


- (IBAction)shareAction:(id)sender {
   
    NSArray * shareItems = @[self.displayedImage];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    // Present the controller
    [self presentViewController:controller animated:YES completion:nil];
}
@end
