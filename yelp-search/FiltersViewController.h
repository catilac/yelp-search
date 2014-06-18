//
//  FiltersViewController.h
//  yelp-search
//
//  Created by Chirag Davé on 6/17/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FiltersViewControllerDelegate <NSObject>

- (void)dismissFilterView;

@end

@interface FiltersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <FiltersViewControllerDelegate> delegate;

@end
