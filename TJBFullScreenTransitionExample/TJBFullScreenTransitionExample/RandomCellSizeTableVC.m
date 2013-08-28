//
//  RandomCellSizeTableVC.m
//  iMatchBox
//
//  Created by Tyler Barth on 2013-05-27.
//  Copyright (c) 2013年 Gabble. All rights reserved.
//

#import "RandomCellSizeTableVC.h"
#include <stdlib.h>
#import "UIViewController+TJBFullScreenTransition.h"
#import "TimelineCell.h"
#import "RandomChinese.h"
#import "PresentedViewController.h"

@interface RandomCellSizeTableVC ()

@property (nonatomic, strong) NSArray* content;

@end

@implementation RandomCellSizeTableVC

static int rows = 20;

static NSString *CellIdentifier = @"RandomCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"TimelineCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
}

- (NSArray*) content
{
    if (!_content) {
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < rows; ++i) {
            [array addObject:[RandomChinese randomChinese]];
        }
        _content = array;
    }
    
    return _content;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rows;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [self.content[[indexPath row]] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0f] constrainedToSize:CGSizeMake(300.0f, 999999.0f) lineBreakMode:NSLineBreakByWordWrapping];

    return size.height + 54.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.textView setText:self.content[[indexPath row]]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimelineCell *cell = (TimelineCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    CGRect position = [cell.chatBubble convertRect:cell.chatBubble.frame toView:nil];
 
    
    PresentedViewController * vc = [[UIStoryboard storyboardWithName:@"TempStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"PresentedVC"];
    
    [vc setLabelContents:self.content[[indexPath row]]];
    //[vc setContainedVC:[[ContainedTableVC alloc] init]];
    //UIViewController *vc = [[ContainedTableVC alloc] init];
    [vc setFullScreenStartFrame:position];
    

    [self presentViewControllerFullScreen:vc animated:YES completion:^{
    }];
    
}

@end
