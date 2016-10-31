/*
 * Copyright (c) 2015 Pawel Dudek. All rights reserved.
 */
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@class PBDCoreDataMigrationAssistant;

@protocol PBDMigrationAssistantDelegate <NSObject>

- (NSMappingModel *)mappingModelForMigrationAssistant:(PBDCoreDataMigrationAssistant *)assistant;

- (void)migrationAssistant:(PBDCoreDataMigrationAssistant *)assistant didFailToInferMappingModelWithError:(NSError *)error;

@end

@interface PBDCoreDataMigrationAssistant : NSObject
@property(nonatomic, strong) NSFileManager *fileManager;

@property(nonatomic, readonly) NSManagedObjectModel *sourceModel;
@property(nonatomic, readonly) NSManagedObjectModel *destinationModel;

@property(nonatomic, readonly) NSURL *storeURL;

@property(nonatomic, weak, nullable) id <PBDMigrationAssistantDelegate> delegate;

- (instancetype)initWithStoreURL:(NSURL *)storeURL sourceModel:(NSManagedObjectModel *)sourceModel destinationModel:(NSManagedObjectModel *)destinationModel;

- (BOOL)migrateStoreWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
