//
//  Event.m
//  MeetMeUp
//
//  Created by Dave Krawczyk on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Event.h"
#import <UIKit/UIKit.h>

@implementation Event


- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.name = dictionary[@"name"];
        

        self.eventID = dictionary[@"id"];
        self.RSVPCount = [NSString stringWithFormat:@"%@",dictionary[@"yes_rsvp_count"]];
        self.hostedBy = dictionary[@"group"][@"name"];
        self.eventDescription = dictionary[@"description"];
        self.address = dictionary[@"venue"][@"address"];
        self.eventURL = [NSURL URLWithString:dictionary[@"event_url"]];
        self.photoURL = [NSURL URLWithString:dictionary[@"photo_url"]];
    }
    return self;
}

+ (NSArray *)eventsFromArray:(NSArray *)incomingArray
{
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:incomingArray.count];
    
    for (NSDictionary *d in incomingArray) {
        Event *e = [[Event alloc]initWithDictionary:d];
        [newArray addObject:e];
        
    }
    return newArray;
}

+ (void)performSearchForKeyword:(NSString *)keyword  andCompletion:(void (^)(NSArray *searchResult))complete
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=2a73e5e6f7f57437453f5335403774",keyword]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSArray *jsonArray = [[NSJSONSerialization JSONObjectWithData:data
                                                                  options:NSJSONReadingAllowFragments
                                                                    error:nil] objectForKey:@"results"];
            
            
            
            
            NSArray *dataArray = [Event eventsFromArray:jsonArray];
            
            complete(dataArray);
            

            
        }
 
    }];
    [task resume];
}


- (void)findCommentsForEvent:(void(^)(NSArray *comments))complete
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=2a73e5e6f7f57437453f5335403774", self.eventID]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *jsonArray = [dict objectForKey:@"results"];
        
        NSArray *dataArray = [Comment objectsFromArray:jsonArray];
        
        complete(dataArray);
        
    }];
    [task resume];
    
}

- (void)getImageForEvent:(void(^)(UIImage *eventImage))complete
{
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:self.photoURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        complete([UIImage imageWithData:data]);
    }];
    [task resume];
    
    
}






@end
