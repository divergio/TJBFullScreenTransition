//
//  TimelineCell.h
//  iMatchBox
//
//  Created by Tyler Barth on 2013-05-27.
//  Copyright (c) 2013年 Gabble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *chatBubble;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@end
