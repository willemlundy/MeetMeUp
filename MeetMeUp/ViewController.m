//
//  ViewController.m
//  MeetMeUp
//
//  Created by Dave Krawczyk on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Event.h"
#import "EventDetailViewController.h"
#import "ViewController.h"

@interface ViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchBar;
@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];

    [self performSearchWithKeyword:@"mobile"];

}

- (void)performSearchWithKeyword:(NSString *)keyword
{

    [Event performSearchForKeyword:keyword andCompletion:^(NSArray *searchResult) {
        self.dataArray = searchResult;
        [self.tableView reloadData];
    }];
    

}

#pragma mark - Tableview Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    
    Event *event = self.dataArray[indexPath.row];
    
    cell.textLabel.text = event.name;
    cell.detailTextLabel.text = event.address;
    if (event.photoURL)
    {
        [event getImageForEvent:^(UIImage *eventImage) {
            cell.imageView.image = eventImage;
            [cell layoutSubviews];
        }];
        
        
        
//        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:event.photoURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                cell.imageView.image = [UIImage imageWithData:data];
//                [cell layoutSubviews];
//            });
//        }];
//        [task resume];
    }else
    {
       [cell.imageView setImage:[UIImage imageNamed:@"logo"]];
    }
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EventDetailViewController *detailVC = [segue destinationViewController];

    Event *event = self.dataArray[self.tableView.indexPathForSelectedRow.row];
    detailVC.event = event;
}

#pragma searchbar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self performSearchWithKeyword:searchBar.text];
    [searchBar resignFirstResponder];
}

@end
