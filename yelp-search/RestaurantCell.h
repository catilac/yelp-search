//
//  RestaurantCell.h
//  yelp-search
//
//  Created by Chirag Davé on 6/16/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantImageView.h"
#import "Restaurant.h"

@interface RestaurantCell : UITableViewCell

- (void)setRestaurant:(Restaurant *)restaurant;

@end
