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
#import "FiltersViewController.h"
#import "Filter.h"

NSString * const kYelpConsumerKey = @"dHo-BOth2LTppbddxlXnGw";
NSString * const kYelpConsumerSecret = @"t_9J-Kgf2NT-JA3tJ3LnU3FGswk";
NSString * const kYelpToken = @"4mjmES_gMufhqxBsVqbDnO2wq-mJATgx";
NSString * const kYelpTokenSecret = @"YbaDOBV1GRIVnpw-ks3rD_sOhWc";


@interface RestaurantsViewController ()

@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *restaurants;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) Filter *filter;

@end

@implementation RestaurantsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // setup search bar & controls
        self.searchBar = [[UISearchBar alloc] init];
        self.searchBar.delegate = self;
        self.navigationItem.titleView = self.searchBar;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self action:@selector(showFilterOptions)];
    }
    return self;
}

- (void)showFilterOptions {
    FiltersViewController *filtersVC = [[FiltersViewController alloc] init];
    filtersVC.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:filtersVC];
    
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)performSearch:(NSString *)query filter:(Filter *)filter {
    [self.client searchWithTerm:query filter:filter success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response[@"businesses"]);
        self.restaurants = [Restaurant restaurantsWithArray:response[@"businesses"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 115;

    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantCell" bundle:nil]
         forCellReuseIdentifier:@"RestaurantCell"];
    
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
    self.searchText = @"thai";
    [self performSearch:@"thai" filter:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurants.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell *restaurantCell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell"];
    Restaurant *restaurant = self.restaurants[indexPath.row];
    [restaurantCell setRestaurant:restaurant];

    return restaurantCell;
    
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    self.searchText = [searchBar text];
    [self performSearch:self.searchText filter:self.filter];
}

#pragma mark FiltersViewControllerDelegate methods

- (void)dismissFilterView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissFilterViewAndSearch:(Filter *)filter {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.filter = filter;
    [self performSearch:self.searchText filter:self.filter];
}




@end
