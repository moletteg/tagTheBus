//
//  photoCell.h
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
