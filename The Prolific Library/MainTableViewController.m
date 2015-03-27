//
//  MainTableViewController.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 23.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "MainTableViewController.h"
#import "BookTableViewCell.h"

@implementation MainTableViewController {
    NSMutableArray *_books;
}

#pragma mark INITIALIZATION

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *book = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"The Core iOS Developer's Cookbook", @"title",
                                 @"Erica Sadum", @"author",
                                 nil];
    _books = [NSMutableArray arrayWithObjects:book, nil];
}

#pragma mark TABLE VIEW DELEGATE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *book = _books[indexPath.row];
    
    BookTableViewCell *cell = (BookTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BookCell"];
    cell.authorLabel.text = [book objectForKey:@"author"];
    cell.titleLabel.text = [book objectForKey:@"title"];
    return cell;
}

@end
