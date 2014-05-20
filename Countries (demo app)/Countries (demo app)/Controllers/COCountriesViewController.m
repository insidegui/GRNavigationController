//
//  COCountriesViewController.m
//  Countries (demo app)
//
//  Created by Guilherme Rambo on 20/05/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "COCountriesViewController.h"
#import "COSingleCountryViewController.h"

@interface COCountriesViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, copy) NSArray *countries;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSSearchField *searchField;

@property (unsafe_unretained) IBOutlet COSingleCountryViewController *singleCountryVC;

@end

@implementation COCountriesViewController

#define kFlagsDirectory @"/Library/Application Support/Apple/iChat Icons/Flags/"

/*
 Prepare the data when the view is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setTarget:self];
    [self.tableView setDoubleAction:@selector(doubleClickedRow:)];
    
    // find all files inside the flags directory and insert them into our countries array
    
    NSMutableArray *countries = [[NSMutableArray alloc] init];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:kFlagsDirectory];
    for (NSString *fileName in dirEnum) {
        if (![fileName.pathExtension isEqualToString:@"png"]) continue;
        
        NSDictionary *country = @{@"name": [fileName stringByDeletingPathExtension],
                                  @"flag": [kFlagsDirectory stringByAppendingPathComponent:fileName]};
        [countries addObject:country];
    }
    
    self.countries = countries;
    [self.tableView reloadData];
}

/*
 fade out the search field when our view is appearing,
  any animation performed here is grouped with the navigation
 */
- (void)viewWillAppear:(BOOL)animated
{
    // search field fade in animation
    {
        [self.searchField setHidden:NO];
        [self.searchField.animator setAlphaValue:1];
    }
}

/* 
 fade out the search field when our view is disappearing,
 any animation performed here is grouped with the navigation
 */
- (void)viewWillDisappear:(BOOL)animated
{
    // search field fade out animation
    [self.searchField.animator setAlphaValue:0];
}

/*
 this happens right after the disappear animation
 */
- (void)viewDidDisappear:(BOOL)animated
{
    // hide search field after fade animation
    [self.searchField setHidden:YES];
}




/*
 This is just standard tableView stuff...
 */
#pragma mark TableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.countries.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"country" owner:tableView];
    
    NSDictionary *country = self.countries[row];
    
    cellView.textField.stringValue = country[@"name"];
    cellView.imageView.image = [[NSImage alloc] initWithContentsOfFile:country[@"flag"]];
    
    return cellView;
}

- (void)doubleClickedRow:(id)sender
{
    NSDictionary *country = self.countries[self.tableView.clickedRow];
    self.singleCountryVC.country = country;

    [self.navigationController pushViewController:self.singleCountryVC animated:YES];
}

#pragma mark Searching

- (IBAction)searchAction:(id)sender {
    self.searchField.stringValue = @"(not implemented)";
}


@end
