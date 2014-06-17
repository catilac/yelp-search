//
//  Restaurant.m
//  yelp-search
//
//  Created by Chirag Davé on 6/16/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.rating = [[NSURL alloc] initWithString:dictionary[@"rating_img_url"]];
        self.image = [[NSURL alloc] initWithString:dictionary[@"image_url"]];
    }
    
    return self;
}

+ (NSArray *)restaurantsWithArray:(NSArray *)array {
    NSMutableArray *restaurants = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in array) {
        Restaurant *restaurant = [[Restaurant alloc] initWithDictionary:dictionary];
        [restaurants addObject:restaurant];
    }
    
    return restaurants;
}


@end
