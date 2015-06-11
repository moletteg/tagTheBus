//
//  Photo.m
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import "Photo.h"
#import "AppDelegate.h"

@implementation Photo

@dynamic busName;
@dynamic imgPath;
@dynamic name;
@dynamic date;


+(NSArray *)getPhotosByBus:(NSString *)busLine{
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"busName", busLine];
    [fetchRequest setPredicate:predicate];
    
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (fetchError) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", fetchError, fetchError.localizedDescription);
        
    } else {
        NSLog(@"MY RESULT : %@", result);
    }
    return result;
}

+(void)addPhoto :(NSString *)name :(NSString *)imgPath :(NSString *)busNumber {
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    Photo *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    [newPhoto setValue:name forKey:@"name"];
    [newPhoto setValue:imgPath forKey:@"imgPath"];
    [newPhoto setValue:busNumber forKey:@"busName"];
    [newPhoto setDate:[NSDate date]];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

@end
