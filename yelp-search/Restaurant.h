//
//  Restaurant.h
//  yelp-search
//
//  Created by Chirag Davé on 6/16/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *rating;
@property (nonatomic, strong) NSURL *image;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)restaurantsWithArray:(NSArray *)array;

@end
