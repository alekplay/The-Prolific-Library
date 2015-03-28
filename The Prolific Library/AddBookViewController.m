//
//  AddBookViewController.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 27.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "AddBookViewController.h"

@interface AddBookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bookTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *bookAuthorTextField;
@property (weak, nonatomic) IBOutlet UITextField *bookPublisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *bookCategoriesTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;
@end

@implementation AddBookViewController

#pragma mark INITIALIZATION

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bookTitleTextField becomeFirstResponder];
    
    if (self.book != nil) {
        self.title = @"Edit book";
        self.bookTitleTextField.text = self.book.title;
        self.bookAuthorTextField.text = self.book.author;
        self.bookPublisherTextField.text = self.book.publisher == (id)[NSNull null] ? nil: self.book.publisher;
        self.bookCategoriesTextField.text = self.book.category == (id)[NSNull null] ? nil: self.book.category;
    }
}

#pragma mark ACTIONS

- (IBAction)saveButtonDidPress:(id)sender {
    if ([self.bookTitleTextField.text length] > 0 && [self.bookAuthorTextField.text length] > 0) {
        NSMutableDictionary *bookDict = [NSMutableDictionary dictionary];
        [bookDict setObject:self.bookTitleTextField.text forKey:@"title"];
        [bookDict setObject:self.bookAuthorTextField.text forKey:@"author"];
        [bookDict setObject:self.bookPublisherTextField.text forKey:@"publisher"];
        [bookDict setObject:self.bookCategoriesTextField.text forKey:@"categories"];
        
        BooksHTTPClient *client = [BooksHTTPClient sharedClient];
        client.delegate = self;
        
        if (self.currentStyle == AddBookVCStyleAddingBook) {
            [client addBook:bookDict];
        } else if (self.currentStyle == AddBookVCStyleEditingBook) {
            [client editBook:self.book withDict:bookDict];
        }
        
        
        [self.saveBarButtonItem setEnabled:NO];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Title and Author are required" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)cancelButtonDidPress:(id)sender {
    if (self.currentStyle == AddBookVCStyleAddingBook) {
        if ([self.bookTitleTextField.text length] > 0 || [self.bookAuthorTextField.text length] > 0 || [self.bookPublisherTextField.text length] > 0 || [self.bookCategoriesTextField.text length] > 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unsaved changes" message:@"Are you sure you want to leave? Your book will not be saved" delegate:self cancelButtonTitle:@"Don't leave" otherButtonTitles:@"Leave", nil];
            [alertView show];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark BOOKS HTTP CLIENT DELEGATE

- (void)booksHTTPClient:(BooksHTTPClient *)client didAddBook:(id)book {
    self.book = [[Book alloc] initWithDictionary:book];
    [self.delegate addBook:self.book];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateBook:(id)book {
    self.book = [[Book alloc] initWithDictionary:book];
    [self.delegate updateBook:self.book];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error {
    NSLog(@"Failed with error: %@", [error localizedDescription]);
    
    [self.saveBarButtonItem setEnabled:YES];
}

#pragma mark ALERT VIEW DELEGATE

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Leave"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
