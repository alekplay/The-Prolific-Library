//
//  BookDetailViewController.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 26.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "BookDetailViewController.h"
#import "AddBookViewController.h"
#import "ShareDialog.h"
#import "CheckoutTimeFormatter.h"

@interface BookDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkedOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkedOutHeader;

@end

@implementation BookDetailViewController

#pragma mark INITIALIZATION

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layOutData];
}

- (void)layOutData {
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    self.categoryLabel.text = [NSString stringWithFormat:@"Categories: %@", self.book.category];
    
    if (self.book.publisher != nil && self.book.publisher != (id)[NSNull null] && [self.book.publisher length] > 0) {
        self.publisherLabel.text = [NSString stringWithFormat:@"Publisher: %@", self.book.publisher];
    } else {
        [self.publisherLabel removeFromSuperview];
        [self.view setNeedsLayout];
    }
    
    if (self.book.lastCheckedOutBy != nil && self.book.lastCheckedOutBy != (id)[NSNull null] && self.book.lastCheckedOut != nil && self.book.lastCheckedOut != (id)[NSNull null]) {
        NSString *dateString = [[CheckoutTimeFormatter sharedFormatter] convertAndFormatDateString:self.book.lastCheckedOut];
        self.checkedOutLabel.text = [NSString stringWithFormat:@"%@ at %@", self.book.lastCheckedOutBy, dateString];
    } else {
        [self.checkedOutLabel removeFromSuperview];
        [self.checkedOutHeader removeFromSuperview];
        [self.view setNeedsLayout];
    }
}

#pragma mark ACTIONS

- (IBAction)checkOutButtonDidPress:(id)sender {
    [self askForName];
}

- (IBAction)shareButtonDidPress:(id)sender {
    [self presentViewController:[[ShareDialog alloc] initWithBook:self.book.title andAuthor:self.book.author] animated:YES completion:nil];
}

- (IBAction)editBookButtonDidPress:(id)sender {
    UINavigationController *addBookNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddBookNavigationController"];
    AddBookViewController *addBookViewController = addBookNavigationController.viewControllers[0];
    addBookViewController.book = self.book;
    addBookViewController.currentStyle = AddBookVCStyleEditingBook;
    addBookViewController.delegate = self;
    [self presentViewController:addBookNavigationController animated:YES completion:nil];
}

#pragma mark BOOKS HTTP CLIENT DELEGATE

- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateBook:(id)book {
    [self.book updateBookWithDictionary:book];
    [self.delegate updatedBook:self.book];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark ALERT VIEW (DELEGATE)

- (void)askForName {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter your name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Checkout", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Checkout"]) {
        NSString *name = [[alertView textFieldAtIndex:0] text];
        
        if ([name length] > 0) {
            BooksHTTPClient *client = [BooksHTTPClient sharedClient];
            client.delegate = self;
            [client checkOutBook:self.book forUser:name];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't checkout book" message:@"You need to provide a name before checking out your book" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Ok"]) {
        [self askForName];
    }
}

#pragma mark ADD BOOK VIEW CONTROLLER DELEGATE

- (void)updateBook:(Book *)book {
    self.book = book;
    [self layOutData];
    [self.delegate updatedBook:book];
}

@end
