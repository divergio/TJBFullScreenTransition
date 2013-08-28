//
//  TimelineCell.m
//  iMatchBox
//
//  Created by Tyler Barth on 2013-05-27.
//  Copyright (c) 2013年 Gabble. All rights reserved.
//

#import "TimelineCell.h"

@interface TimelineCell ()


@end

@implementation TimelineCell

- (void) awakeFromNib
{
    [super awakeFromNib];
    
   [self.chatBubble setImage:[[UIImage imageNamed:@"amateur_chat_bubble.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10,4,51,7)]];
}

@end
