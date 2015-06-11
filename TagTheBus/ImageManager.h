//
//  ImageManager.h
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageManager : NSObject

+ (void)saveImage:(UIImage *)image :(NSString*)imageName;
+ (UIImage*)loadImage:(NSString *)imgName;
+ (void) deleteImage :(NSString*)imageName;
@end
