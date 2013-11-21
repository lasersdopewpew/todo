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

+ (id) makeTodo:(NSString*)itemName completed:(BOOL)completed cretionDate:(NSDate *)creationDate{
    TodoItem * result = [TodoItem new];
    [result setItemName:itemName];
    [result setCompleted:completed];
    result->creationDate = creationDate;
    
    return result;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.creationDate forKey:@"creationDate"];
    [encoder encodeObject:self.itemName forKey:@"itemName"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.itemName = [decoder decodeObjectForKey:@"itemName"];
    }
    return self;
}

@end
