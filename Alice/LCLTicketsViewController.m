//
//  LCLTicketsViewController.m
//  Alice
//
//  Created by Leonard Li on 4/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLTicketsViewController.h"
#import "LCLTicketDataManager.h"
#import "LCLTicketDataStore.h"

@interface LCLTicketsViewController ()
@property (strong, nonatomic) LCLTicketDataStore *dataStore;
@property (strong, nonatomic) LCLTicketDataManager *dataManager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LCLTicketsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataStore.ticketFRController.sections[0] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ticketCell"];
    Ticket *ticket = [self.dataStore.ticketFRController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Id: %@, Status: %@", ticket.id, ticket.status];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ticket *selectedticket = [self.dataStore.ticketFRController objectAtIndexPath:indexPath];
    [self selectCurrentTicket:selectedticket
               WithCompletion:^(BOOL isSuccessful) {
       [self performSegueWithIdentifier:@"ticketsToTicketDetailSegue" sender:self];
    }];
}

#pragma mark - FetchedResultsController Methods


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    if ([controller isEqual:self.dataStore.ticketFRController])
    {
        newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:0];
        
    }
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView cellForRowAtIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

#pragma mark - Helper Methods

- (void) initialize
{
    self.dataStore = [LCLTicketDataStore sharedDataStore];
    self.dataManager = [LCLTicketDataManager sharedManager];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.dataStore.ticketFRController.delegate = self;
}

- (void) selectCurrentTicket:(Ticket *)selectedTicket
              WithCompletion:(void (^)(BOOL isSuccessful))completionBlock
{
    self.dataStore.currentTicket = selectedTicket;
    if (selectedTicket) completionBlock(YES);
}

@end
