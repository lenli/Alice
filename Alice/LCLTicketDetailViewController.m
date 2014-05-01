//
//  LCLTicketDetailViewController.m
//  Alice
//
//  Created by Leonard Li on 4/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLTicketDetailViewController.h"
#import "LCLTicketDataStore.h"

@interface LCLTicketDetailViewController ()

@property (strong, nonatomic) LCLTicketDataStore *dataStore;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketLabel;
@property (weak, nonatomic) IBOutlet UILabel *doneLabel;
@end

@implementation LCLTicketDetailViewController

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

- (void)initialize
{
    self.dataStore = [LCLTicketDataStore sharedDataStore];
    self.idLabel.text = [NSString stringWithFormat:@"%@",self.dataStore.currentTicket.id];
    self.statusLabel.text = self.dataStore.currentTicket.status;
    self.ticketLabel.text = self.dataStore.currentTicket.ticketType;
    self.doneLabel.text = [NSString stringWithFormat:@"%@",self.dataStore.currentTicket.isDone];
}
@end
