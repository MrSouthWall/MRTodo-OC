//
//  Todo+CoreDataClass.h
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/7.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Folder, Tag, TomatoClock;

NS_ASSUME_NONNULL_BEGIN

@interface Todo : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Todo+CoreDataProperties.h"
