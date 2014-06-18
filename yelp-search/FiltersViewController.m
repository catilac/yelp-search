//
//  FiltersViewController.m
//  yelp-search
//
//  Created by Chirag Davé on 6/17/14.
//  Copyright (c) 2014 Chirag Davé. All rights reserved.
//

#import "FiltersViewController.h"

static int const MIN_CATEGORIES = 3;
static int const DEALS_SECTION = 2;
static int const CATEGORIES_SECTION = 3;
static int const SHOW_ALL_ROW = 3;

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

        self.sections = @[@"Sort By", @"Radius", @"Deals", @"Categories"];

        self.collapsed = [[NSMutableDictionary alloc] initWithObjects:@[@YES, @YES, @YES, @YES] forKeys:self.sections];
        
        self.filterValues = [[NSMutableDictionary alloc] initWithObjects:@[@[@"Best Match", @"Distance", @"Rating"],
                                                                           @[@"Auto", @"2 Blocks", @"6 Blocks", @"1 mi", @"5 mi"],
                                                                           @[@"Offering a Deal"],
                                                                           @[@"Food", @"Bars", @"Professional Services",
                                                                             @"Automotive", @"Education", @"Doctors"]]
                                                                 forKeys:self.sections];
        
        self.currentValues = [[NSMutableDictionary alloc] initWithObjects:@[@"Best Match", @"Auto", @"Offering a Deal", @"Food"]
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
    Boolean showAllPressed = (indexPath.section == CATEGORIES_SECTION &&
                              indexPath.row == SHOW_ALL_ROW &&
                              [[self.collapsed objectForKey:filter] isEqual:@YES]);
    Boolean notCategoriesAndNotDeals = (indexPath.section != CATEGORIES_SECTION && indexPath.section != DEALS_SECTION);
    
    if (notCategoriesAndNotDeals) {
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
    } else if (showAllPressed) {
         [self.collapsed setObject:@NO forKey:filter];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                      withRowAnimation:UITableViewRowAnimationAutomatic];

    }
    
}


#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *filterCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (filterCell == nil) {
        filterCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier];
    }
    
    NSString *filter = self.sections[indexPath.section];

    Boolean showAllButton = (indexPath.section == CATEGORIES_SECTION &&
                              indexPath.row == SHOW_ALL_ROW &&
                              [[self.collapsed objectForKey:filter] isEqual:@YES]);

    
    if (indexPath.section == CATEGORIES_SECTION || indexPath.section == DEALS_SECTION) {
        // add a UISwitch
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        filterCell.accessoryView = switchView;
    } else {
        filterCell.accessoryView = nil;
    }
    
    if (showAllButton) {
        filterCell.accessoryView = nil;
    }
    
    if ([[self.collapsed objectForKey:filter] isEqual:@YES]) {
        if (indexPath.section == CATEGORIES_SECTION ) {
            if (indexPath.row == SHOW_ALL_ROW) {
                filterCell.textLabel.text = @"Show All";
            } else {
                NSArray *values = [self.filterValues objectForKey:filter];
                filterCell.textLabel.text = values[indexPath.row];
            }
        } else {
            filterCell.textLabel.text = [self.currentValues objectForKey:filter];
        }
        
    } else {
        NSArray *values = [self.filterValues objectForKey:filter];
        filterCell.textLabel.text = values[indexPath.row];
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
        if ([sectionName isEqual:@"Categories"]) {
            // Show Minimum number of categories plus room for "Show All"
            return MIN_CATEGORIES + 1;
        }

        return 1;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section];
}

@end
