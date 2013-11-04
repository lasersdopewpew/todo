//
//  TodoItem.h
//  todo
//
//  Created by Mac on 11/1/13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject{
    NSString *itemName;
    BOOL completed;
    NSDate *creationDate;
}
- (NSString*)itemName;
- (void)setItemName: (NSString*)newValue;

- (BOOL) completed;
- (void) setCompleted: (BOOL)state;

- (NSDate *) creationDate;



@end