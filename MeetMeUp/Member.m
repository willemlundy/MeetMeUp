//
//  Member.m
//  MeetMeUp
//
//  Created by Dave Krawczyk on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Member.h"

@implementation Member

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.state = dictionary[@"state"];
        self.city = dictionary[@"city"];
        self.country = dictionary[@"country"];
        
        self.photoURL = [NSURL URLWithString:dictionary[@"photo"][@"photo_link"]];
        
        
    }
    return self;
}

+ (void)findMemberForMemberID:(NSString *)memberID andCompletion:(void (^)(Member *member))complete
{
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/member/%@?&sign=true&photo-host=public&page=20&key=2a73e5e6f7f57437453f5335403774", memberID]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        Member *member = [[Member alloc]initWithDictionary:dict];
        complete(member);
        
    }];
    [task resume];
}

- (void)getImageForMember:(void(^)(UIImage *memberImage))complete
{
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:self.photoURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        complete([UIImage imageWithData:data]);
    }];
    [task resume];
    
    
}

@end
