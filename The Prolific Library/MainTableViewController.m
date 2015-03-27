//
//  MainTableViewController.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 23.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "MainTableViewController.h"
#import "BookTableViewCell.h"
#import "Book.h"
#import "BookDetailViewController.h"

@implementation MainTableViewController {
    NSMutableArray *_books;
}

#pragma mark INITIALIZATION

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _books = [NSMutableArray array];
    
    BooksHTTPClient *client = [BooksHTTPClient sharedClient];
    client.delegate = self;
    [client getBooks];
}

#pragma mark TABLE VIEW DATA SOURCE & DELEGATE

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Book *book = _books[indexPath.row];
    
    BookTableViewCell *cell = (BookTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BookCell"];
    cell.authorLabel.text = book.author;
    cell.titleLabel.text = book.title;
    return cell;
}

#pragma mark BOOKS HTTP CLIENT DELEGATE

- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithBooks:(id)books {
    for (NSDictionary *bookDict in books) {
        Book *newBook = [[Book alloc] initWithDictionary:bookDict];
        [_books addObject:newBook];
    }
    
    [self.tableView reloadData];
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error {
    NSLog(@"Failed: %@", error);
}

#pragma mark OTHER

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BookDetailSegue"]) {
        BookDetailViewController *bdvc = [segue destinationViewController];
        bdvc.book = _books[[self.tableView.indexPathForSelectedRow row]];
    }
}

@end
