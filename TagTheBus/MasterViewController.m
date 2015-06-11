//
//  MasterViewController.m
//  TagTheBus
//
//  Copyright (c) 2015 Gregory Molette. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <UIKit/UIKit.h>
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "Line.h"

@interface MasterViewController ()

@property NSArray *busAdresses;
@property NSArray *busLines;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self requestBusLineData];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showPhoto"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        Line * myLine = [self.busLines objectAtIndex:indexPath.row];
        destViewController.title = [NSString stringWithFormat:@"Bus number %@",myLine.line];
        destViewController.bus = myLine;
    }
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.busLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Line *myLine = self.busLines[indexPath.row];
    cell.textLabel.text = myLine.line;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",myLine.origin,myLine.destination];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


#pragma mark - RESTKit

- (void)requestBusLineData {
    
    NSString *requestPath = @"/bus/lines.json";
    [[RKObjectManager sharedManager]
     getObjectsAtPath:requestPath
     parameters:nil
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         //bus have been saved in core data by now
         [self fetchLinesFromContext];
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
    
}

- (void)fetchLinesFromContext {
    
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Line"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"line" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    self.busLines = [context executeFetchRequest:fetchRequest error:&error];
    [self.tableView reloadData];
    
}

@end
