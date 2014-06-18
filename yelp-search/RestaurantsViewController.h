//
//  RestaurantsViewController.h
//  yelp-search
//
//  Created by Chirag Davé on 6/16/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersViewController.h"

@interface RestaurantsViewController : UIViewController <UITableViewDataSource, UISearchBarDelegate, FiltersViewControllerDelegate>

@end
