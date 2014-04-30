//
//  LCLLoginViewController.m
//  Alice
//
//  Created by Leonard Li on 4/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLLoginViewController.h"
#import "LCLTicketDataManager.h"

@interface LCLLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) LCLTicketDataManager *dataManager;

@end

@implementation LCLLoginViewController

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
    self.dataManager = [LCLTicketDataManager sharedManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTapped:(UIButton *)sender
{
    
    [self.dataManager authenticateWithUsername:self.usernameTextField.text
                                  withPassword:self.passwordTextField.text
                                withCompletion:^(BOOL isSuccessful) {
        
    }];
}


@end
