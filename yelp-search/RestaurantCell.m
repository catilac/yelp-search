//
//  RestaurantCell.m
//  yelp-search
//
//  Created by Chirag Davé on 6/16/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import "RestaurantCell.h"

@interface RestaurantCell ()
@property (weak, nonatomic) IBOutlet RestaurantImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation RestaurantCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRestaurant:(Restaurant *)restaurant {
    self.nameLabel.text = restaurant.name;
    [self.ratingImage setImageWithURL:restaurant.rating];
    [self.restaurantImage setImageWithURL:restaurant.image];
    [self.restaurantImage fadeIn];
}

@end
