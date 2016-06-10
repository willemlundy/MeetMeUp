//
//  Member.h
//  MeetMeUp
//
//  Created by Dave Krawczyk on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Member : NSObject


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSURL *photoURL;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (void)findMemberForMemberID:(NSString *)memberID andCompletion:(void (^)(Member *member))complete;
- (void)getImageForMember:(void(^)(UIImage *memberImage))complete;

@end
