//
//  RestaurantsViewController.m
//  yelp-search
//
//  Created by Chirag Davé on 6/16/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import "RestaurantsViewController.h"
#import "YelpClient.h"

NSString * const kYelpConsumerKey = @"dHo-BOth2LTppbddxlXnGw";
NSString * const kYelpConsumerSecret = @"t_9J-Kgf2NT-JA3tJ3LnU3FGswk";
NSString * const kYelpToken = @"4mjmES_gMufhqxBsVqbDnO2wq-mJATgx";
NSString * const kYelpTokenSecret = @"YbaDOBV1GRIVnpw-ks3rD_sOhWc";


@interface RestaurantsViewController ()

@property (nonatomic, strong) YelpClient *client;

@end

@implementation RestaurantsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                               consumerSecret:kYelpConsumerSecret
                                                  accessToken:kYelpToken
                                                 accessSecret:kYelpTokenSecret];

        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"response: %@", response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
