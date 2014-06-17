//
//  PosterImageView.m
//  rotten-tomatoes
//
//  Created by Chirag Davé on 6/5/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import "RestaurantImageView.h"

@implementation RestaurantImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.alpha = 0.0f;
    }
    return self;
}

-(void)fadeIn {
    [UIView animateWithDuration:1.0f animations:^ {
        self.alpha = 1.0f;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
