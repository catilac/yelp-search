//
//  RestaurantsViewController.m
//  yelp-search
//
//  Created by Chirag Davé on 6/16/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import "RestaurantsViewController.h"
#import "YelpClient.h"
#import "Restaurant.h"
#import "RestaurantCell.h"

NSString * const kYelpConsumerKey = @"dHo-BOth2LTppbddxlXnGw";
NSString * const kYelpConsumerSecret = @"t_9J-Kgf2NT-JA3tJ3LnU3FGswk";
NSString * const kYelpToken = @"4mjmES_gMufhqxBsVqbDnO2wq-mJATgx";
NSString * const kYelpTokenSecret = @"YbaDOBV1GRIVnpw-ks3rD_sOhWc";


@interface RestaurantsViewController ()

@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *restaurants;

@end

@implementation RestaurantsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 115;

    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantCell" bundle:nil]
         forCellReuseIdentifier:@"RestaurantCell"];
    
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response[@"businesses"]);
        self.restaurants = [Restaurant restaurantsWithArray:response[@"businesses"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell *restaurantCell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell"];
    Restaurant *restaurant = self.restaurants[indexPath.row];
    [restaurantCell setRestaurant:restaurant];

    return restaurantCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

@end
