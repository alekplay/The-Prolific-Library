//
//  ShareDialog.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 28.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareDialog : UIActivityViewController

- (instancetype)initWithBook:(NSString *)bookTitle andAuthor:(NSString *)authorName;

@end
