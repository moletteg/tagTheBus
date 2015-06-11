//
//  PhotoViewController.h
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"


@interface PhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic) Line *bus;

@end
