//
//  FiltersViewController.m
//  yelp-search
//
//  Created by Chirag Davé on 6/17/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import "FiltersViewController.h"
#import "FilterCell.h"

@interface FiltersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *filterOptions;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Filters";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self action:@selector(didPressCancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self action:@selector(didPressSearch)];

        self.filterOptions = @{
                               @"Sort By": @{
                                       @"currValue": @"Best Match",
                                       @"open": @YES, @"values": @[@"Best Match", @"Distance", @"Rating"]
                                },
                               @"Radius": @{
                                       @"currValue": @"5 mi",
                                       @"open": @NO, @"values": @[@"2 Blocks", @"6 Blocks", @"1 mi", @"5 mi"]
                                },
                               @"Deals": @{
                                       @"currValue": @"ON",
                                       @"open": @NO, @"values": @[@"ON", @"OFF"]
                                },
                               @"Category": @{
                                       @"currValue": @"Food",
                                       @"open": @NO, @"values": @[@"Food", @"Bars", @"Professional Services"]
                                }
                               };
        
    }
    return self;
}

- (void)didPressCancel {
    [self.delegate dismissFilterView];
}

- (void)didPressSearch {
    [self.delegate dismissFilterView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil]
         forCellReuseIdentifier:@"FilterCell"];

    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterCell *filterCell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell"];

    NSArray *optionKeys = [self.filterOptions allKeys];
    NSDictionary *optionDict = [self.filterOptions objectForKey:optionKeys[indexPath.section]];
    NSArray *optionVals = [optionDict objectForKey:@"values"];
    
    filterCell.filterName.text = optionVals[indexPath.row];
    return filterCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.filterOptions allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keys = [self.filterOptions allKeys];
    NSString *key = keys[section];
    NSDictionary *dict = [self.filterOptions objectForKey:key];
    NSLog(@"%@", [dict objectForKey:@"open"]);
    if ([[dict objectForKey:@"open"]  isEqual: @YES]) {
        NSArray *values = [dict objectForKey:@"values"];
        return [values count];
    }
    return 1;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [self.filterOptions allKeys];
    return keys[section];
}

@end
