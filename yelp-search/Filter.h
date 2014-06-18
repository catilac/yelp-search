//
//  Filter.h
//  yelp-search
//
//  Created by Chirag Davé on 6/18/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject

@property (nonatomic) NSInteger sort;
@property (nonatomic, strong) NSString *category_filter;
@property (nonatomic) NSInteger radius;
@property (nonatomic) Boolean deals;

@end
