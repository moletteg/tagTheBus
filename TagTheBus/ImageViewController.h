//
//  ImageViewController.h
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface ImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)shareAction:(id)sender;
@property (strong, nonatomic) Photo * image;

@end
