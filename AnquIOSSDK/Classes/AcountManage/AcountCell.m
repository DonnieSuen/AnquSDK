//
//  AcountCell.m

//  Created by Jeff on 15-3-21.
//  Copyright (c) 2015年. All rights reserved.
//
//

#import "AcountCell.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@implementation AcountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _orientation = [UIApplication sharedApplication].statusBarOrientation;
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, HEIGHT/2 - 15, 30, 30)];
        _headImage.contentMode=UIViewContentModeScaleToFill;
        [self.contentView addSubview:_headImage];
        
        _labelText = [[UILabel alloc] initWithFrame:CGRectMake(60, HEIGHT/2 - 15, 80, 30)];
        _labelText.font = [UIFont systemFontOfSize:14.0];
         [self.contentView addSubview:_labelText];
        
        _tailImage = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH - 60, HEIGHT/2 - 15, 30, 30)];
         _tailImage.contentMode=UIViewContentModeScaleToFill;
        _tailImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self.contentView addSubview:_tailImage];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
