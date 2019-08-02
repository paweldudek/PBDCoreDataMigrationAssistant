/*
 * Copyright (c) 2015 Pawel Dudek. All rights reserved.
 */
#import <CoreData/CoreData.h>
#import "PBDCoreDataMigrationAssistant.h"

@implementation PBDCoreDataMigrationAssistant

- (instancetype)initWithStoreURL:(NSURL *)storeURL sourceModel:(NSManagedObjectModel *)sourceModel destinationModel:(NSManagedObjectModel *)destinationModel {
    self = [super init];
    if (self) {
        _sourceModel = sourceModel;
        _destinationModel = destinationModel;
        _storeURL = storeURL;

        self.fileManager = [NSFileManager defaultManager];
    }

    return self;
}

- (BOOL)migrateStoreWithError:(NSError **)error {
    NSError *inferringError = nil;
    NSMappingModel *mappingModel = [NSMappingModel inferredMappingModelForSourceModel:self.sourceModel
                                                                     destinationModel:self.destinationModel
                                                                                error:&inferringError];
    if (inferringError) {
        [[self delegate] migrationAssistant:self didFailToInferMappingModelWithError:inferringError];
        mappingModel = [[self delegate] mappingModelForMigrationAssistant:self];
    }

    NSAssert(mappingModel, @"No mapping model for migration assistant was provided.");

    NSURL *storeDirectory = [self.storeURL URLByDeletingLastPathComponent];

    NSString *shmPath = [[self.storeURL relativePath] stringByAppendingString:@"-shm"];
    NSURL *shmURL = [NSURL fileURLWithPath:shmPath];
    NSString *walPath = [[self.storeURL relativePath] stringByAppendingString:@"-wal"];
    NSURL *walURL = [NSURL fileURLWithPath:walPath];
	
    NSURL *temporaryFileURL = [storeDirectory URLByAppendingPathComponent:@"tmp.sqlite"];
    NSURL *temporaryShmURL = [storeDirectory URLByAppendingPathComponent:@"tmp.sqlite-shm"];
    NSURL *temporaryWalURL = [storeDirectory URLByAppendingPathComponent:@"tmp.sqlite-wal"];

    [self.fileManager moveItemAtURL:self.storeURL toURL:temporaryFileURL error:nil];
    [self.fileManager moveItemAtURL:shmURL toURL:temporaryShmURL error:nil];
    [self.fileManager moveItemAtURL:walURL toURL:temporaryWalURL error:nil];

    NSMigrationManager *migrationManager = [[NSMigrationManager alloc] initWithSourceModel:self.sourceModel
                                                                          destinationModel:self.destinationModel];

    NSError *migrationError = nil;
    BOOL migrationSuccessful = [migrationManager migrateStoreFromURL:temporaryFileURL
                                                                type:NSSQLiteStoreType
                                                             options:nil
                                                    withMappingModel:mappingModel
                                                    toDestinationURL:self.storeURL
                                                     destinationType:NSSQLiteStoreType
                                                  destinationOptions:nil
                                                               error:&migrationError];

    [self.fileManager removeItemAtURL:temporaryFileURL error:nil];
    [self.fileManager removeItemAtURL:temporaryShmURL error:nil];
    [self.fileManager removeItemAtURL:temporaryWalURL error:nil];

    if (error) {
        *error = migrationError;
    }

    return migrationSuccessful;
}

@end
