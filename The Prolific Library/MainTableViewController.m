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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[BooksHTTPClient sharedClient] deleteBook:[_books objectAtIndex:indexPath.row]];
        [_books removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark ACTIONS

- (IBAction)trashButtonDidPress:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Do you really want to delete all the books from the library?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes, delete", nil];
    [alertView show];
}

#pragma mark ALERT VIEW DELEGATE

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes, delete"]) {
        [[BooksHTTPClient sharedClient] deleteAllBooks];
        [_books removeAllObjects];
        [self.tableView reloadData];
    }
}

#pragma mark NAVIGATION

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BookDetailSegue"]) {
        BookDetailViewController *bookDetailViewController = [segue destinationViewController];
        bookDetailViewController.book = _books[[self.tableView.indexPathForSelectedRow row]];
        bookDetailViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"AddBookSegue"]) {
        UINavigationController *addBookNavigationController = [segue destinationViewController];
        AddBookViewController *addBookViewController = addBookNavigationController.viewControllers[0];
        addBookViewController.currentStyle = AddBookVCStyleAddingBook;
        addBookViewController.delegate = self;
    }
}

#pragma mark BOOK DETAIL VIEW CONTROLLER DELEGATE

- (void)updatedBook:(Book *)book {
    for (Book *currentBook in _books) {
        if (currentBook.ID == book.ID) {
            [_books replaceObjectAtIndex:[_books indexOfObject:currentBook] withObject:book];
            break;
        }
    }
}

#pragma mark ADD BOOK VIEW CONTROLLER DELEGATE

- (void)addBook:(Book *)book {
    [_books addObject:book];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
