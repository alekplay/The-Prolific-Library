//
//  AddBookViewController.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 27.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "AddBookViewController.h"
#import "Book.h"
#import "BooksHTTPClient.h"

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
        [client addBook:bookDict];
        
        [self.saveBarButtonItem setEnabled:NO];
    } else {
        NSLog(@"Title and author are required!");
    }
}

- (IBAction)cancelButtonDidPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark BOOKS HTTP CLIENT DELEGATE

- (void)booksHTTPClient:(BooksHTTPClient *)client didAddBook:(id)book {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error {
    NSLog(@"Failed with error: %@", [error localizedDescription]);
    
    [self.saveBarButtonItem setEnabled:YES];
}

@end
