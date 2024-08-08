//
//  Tag+CoreDataProperties.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/7.
//
//

#import "Tag+CoreDataProperties.h"

@implementation Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
}

@dynamic name;
@dynamic todos;

@end
