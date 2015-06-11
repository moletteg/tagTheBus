//
//  PhotoViewController.m
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import "AssetsLibrary/AssetsLibrary.h"
#import "PhotoViewController.h"
#import "ImageIO/ImageIO.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "appDelegate.h"
#import "Photo.h"
#import "ImageManager.h"

@interface PhotoViewController ()
@property NSString *photoTitle;
@property NSString *fullpath;
@property UIImage *chosenImage;

@end

@implementation PhotoViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void) addTitle {
    
    UIAlertView * message = [[UIAlertView alloc] initWithTitle:@"Titre" message:@"Choisissez un titre" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    message.alertViewStyle = UIAlertViewStylePlainTextInput;
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    self.photoTitle = [[alertView textFieldAtIndex:0] text];
    [ImageManager saveImage:self.chosenImage :self.photoTitle];
    [Photo addPhoto:self.photoTitle :self.fullpath :self.bus.line];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = self.chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self addTitle];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
