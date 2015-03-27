//
//  BookTableViewCell.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 24.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
