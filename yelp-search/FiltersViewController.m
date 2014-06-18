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
@property (nonatomic, strong) NSMutableDictionary *filterValues;
@property (nonatomic, strong) NSMutableDictionary *currentValues;
@property (nonatomic, strong) NSMutableDictionary *collapsed;
@property (nonatomic, strong) NSArray *sections;

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

        self.sections = @[@"Sort By", @"Radius", @"Deals", @"Category"];

        self.collapsed = [[NSMutableDictionary alloc] initWithObjects:@[@YES, @YES, @YES, @YES] forKeys:self.sections];
        
        self.filterValues = [[NSMutableDictionary alloc] initWithObjects:@[@[@"Best Match", @"Distance", @"Rating"],
                                                                           @[@"Auto", @"2 Blocks", @"6 Blocks", @"1 mi", @"5 mi"],
                                                                           @[@"ON", @"OFF"],
                                                                           @[@"Food", @"Bars", @"Professional Services"]]
                                                                 forKeys:self.sections];
        
        self.currentValues = [[NSMutableDictionary alloc] initWithObjects:@[@"Best Match", @"Auto", @"ON", @"Food"]
                                                                  forKeys:self.sections];
        
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
    NSString *filter = self.sections[indexPath.section];
    
    // Toggle Collapsed
    if ([[self.collapsed objectForKey:filter] isEqual:@YES]) {
        [self.collapsed setObject:@NO forKey:filter];
    } else {
        [self.collapsed setObject:@YES forKey:filter];
        // Set new current value
        NSArray *values = [self.filterValues objectForKey:filter];
        NSString *selectedValue = values[indexPath.row];
        [self.currentValues setObject:selectedValue forKey:filter];
    }
    
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterCell *filterCell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell"];

    NSString *filter = self.sections[indexPath.section];
    if ([[self.collapsed objectForKey:filter] isEqual:@YES]) {
        filterCell.filterName.text = [self.currentValues objectForKey:filter];
    } else {
        NSArray *values = [self.filterValues objectForKey:filter];
        filterCell.filterName.text = values[indexPath.row];
    }
    
    return filterCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionName = self.sections[section];
    
    if ([[self.collapsed objectForKey:sectionName] isEqual:@NO]) {
        // return number of possible values
        return [[self.filterValues objectForKey:sectionName] count];
    } else {
        return 1;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section];
}

@end
