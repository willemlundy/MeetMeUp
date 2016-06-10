//
//  CommentsTableViewController.m
//  MeetMeUp
//
//  Created by Dave Krawczyk on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Event.h"
#import "MemberViewController.h"
#import "CommentTableViewCell.h"
#import "CommentsTableViewController.h"

@interface CommentsTableViewController ()

@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)NSDateFormatter *dateFormatter;

@end

@implementation CommentsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.event findCommentsForEvent:^(NSArray *comments) {
        self.dataArray = comments;
        [self.tableView reloadData];
    }];
    
    

//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=2a73e5e6f7f57437453f5335403774",self.event.eventID]];
//    
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSArray *jsonArray = [dict objectForKey:@"results"];
//        self.dataArray = [Comment objectsFromArray:jsonArray];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//        
//    }];
//    [task resume];

    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    
    Comment *comment = self.dataArray[indexPath.row];
    cell.authorLabel.text = comment.author;
    cell.commentLabel.text = comment.text;
    cell.dateLabel.text = [self.dateFormatter stringFromDate:comment.date];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MemberViewController *memberVC = [segue destinationViewController];

    Comment *comment = self.dataArray[[self.tableView indexPathForSelectedRow].row];
    memberVC.memberID = comment.memberID;
}


@end
