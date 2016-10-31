/*
 * Copyright (c) 2015 Pawel Dudek. All rights reserved.
 */
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBDManagedObjectModelController : NSObject

@property(nonatomic, readonly) NSURL *managedObjectModelURL;

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL;

#pragma mark -

- (void)archiveManagedObjectModel:(NSManagedObjectModel *)model;

- (nullable NSManagedObjectModel *)unarchivedManagedObjectModel;

@end

NS_ASSUME_NONNULL_END
