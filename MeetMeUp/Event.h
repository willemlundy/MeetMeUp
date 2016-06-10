//
//  Event.h
//  MeetMeUp
//
//  Created by Dave Krawczyk on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Comment.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *eventID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *RSVPCount;
@property (nonatomic, strong) NSString *hostedBy;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSURL *eventURL;
@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSArray *commentsArray;

+ (NSArray *)eventsFromArray:(NSArray *)incomingArray;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)getImageForEvent:(void(^)(UIImage *eventImage))complete;
- (void)findCommentsForEvent:(void(^)(NSArray *comments))complete;
+ (void)performSearchForKeyword:(NSString *)keyword  andCompletion:(void (^)(NSArray *searchResult))complete;

@end
