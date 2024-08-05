//
//  CoreDataManager.h
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/8/4.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (instancetype)sharedManager;

- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
