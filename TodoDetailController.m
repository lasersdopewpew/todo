//
//  TodoDetailController.m
//  todo
//
//  Created by Admin on 25.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "TodoDetailController.h"

@interface TodoDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TodoDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)swipeGes:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    self.label.text = self.passedInfo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
