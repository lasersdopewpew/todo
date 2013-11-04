//
//  TodoItem.m
//  todo
//
//  Created by Mac on 11/1/13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem

- (NSString*)itemName{
    return itemName;
}
- (void)setItemName: (NSString*)newValue{
    newValue = [newValue capitalizedString];
    itemName = newValue;
}

- (BOOL) completed{
    return completed;
}
- (void) setCompleted: (BOOL)state{
    completed = state;
}

- (NSDate *) creationDate{
    return creationDate;
}


@end
