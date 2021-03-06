//
//  TodoListViewController.m
//  todo
//
//  Created by Mac on 10/31/13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "TodoListViewController.h"
#import "ToDoItem.h"
#import "TodoDetailController.h"

@interface TodoListViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property NSMutableArray *toDoItems;
    - (void)deleteLastItem;
- (void)saveCustomObject:(NSMutableArray *)object key:(NSString *)key;
- (NSMutableArray *)loadCustomObjectWithKey:(NSString *)key;
@end	

@implementation TodoListViewController

-(void)viewWillAppear:(BOOL)animated{        
    NSLog(@"appear");
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    

//[coder encodeInt:self.tableView forKey:MyViewControllerNumber];
    
}



- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    
   // self.number = [coder decodeIntForKey:MyViewControllerNumber];
    
}

- (void)saveCustomObject:(NSMutableArray *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

- (NSMutableArray *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

- (void)loadInitialData {
    
//    NSData *serialized = [NSKeyedArchiver archivedDataWithRootObject:_toDoItems];
//    [[NSUserDefaults standardUserDefaults] setObject:serialized forKey:@"myKey"];
//    
//    serialized = [[NSUserDefaults standardUserDefaults] objectForKey:@"myKey"];
//    _toDoItems = [NSKeyedUnarchiver unarchiveObjectWithData:serialized];
    
    /*
    TodoItem * item1 =[TodoItem makeTodo:@"Купить молокaaа" completed:YES cretionDate:nil];
    [self.toDoItems addObject:item1];
    TodoItem *item2 = [[TodoItem alloc] init];
    item2.itemName = @"Купить кота";
    [self.toDoItems addObject:item2];
    TodoItem *item3 = [[TodoItem alloc] init];
    item3.itemName = @"Полить цветок";
    [self.toDoItems addObject:item3];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"RU_ru"];
    
    [self.toDoItems addObject:[TodoItem makeTodo: [[NSString alloc] initWithFormat:@"Денег: %@",
                                                   [numberFormatter stringFromNumber:@(1234.5678)]]
                                       completed:YES
                                     cretionDate:nil]];
    */
    self.toDoItems = [self loadCustomObjectWithKey:@"TodoItems"];
    self.restorationIdentifier = @"TodoList";
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)deleteAction:(id)sender {
    //[self deleteLastItem];
//    [self saveCustomObject:self.toDoItems key:@"TodoItems"];
}
- (void) appHasGoneInBackground{
    [self saveCustomObject:self.toDoItems key:@"TodoItems"];
    NSLog(@"Gone background");
}

- (void)deleteLastItem
{
    [self.toDoItems removeLastObject];
    [self.tableView reloadData];
}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    //NSLog(@"Will unload");
//    [self saveCustomObject:self.toDoItems key:@"TodoItems"];
//}
//
//- (void)viewWillUnload{
//   NSLog(@"Will unload");
//     //[self saveCustomObject:self.toDoItems key:@"TodoItems"];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toDoItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appHasGoneInBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    AddToDoItemViewController *source = [segue sourceViewController];
    TodoItem *item = source.toDoItem;
    if (item != nil) {
        [self.toDoItems addObject:item];
        [self.tableView reloadData];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UITableViewCell * cell =  (UITableViewCell*)sender;
    TodoDetailController * contr = segue.destinationViewController;
    contr.passedInfo = [cell text];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.toDoItems count];
}


- (void) actionLongPressGesture:(UILongPressGestureRecognizer*)sender
{
    UITableViewCell *cell = (UITableViewCell*)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"test: %@", cell.textLabel.text);
        NSIndexPath* pathOfTheCell = [self.myTableView indexPathForCell:cell];
        NSInteger rowOfTheCell = [pathOfTheCell row];
        if ([[self.toDoItems objectAtIndex:rowOfTheCell] completed])
        {            
            
        [self.tableView beginUpdates];
        [self.toDoItems removeObjectAtIndex:rowOfTheCell];
        [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject:pathOfTheCell]
                           withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        }
        NSLog(@"row row: %d", rowOfTheCell);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    TodoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    
    UILabel *label;
    label = (UILabel *)[cell viewWithTag:2];
    label.text = [NSString stringWithFormat:@"%d", indexPath.row+1];
    
    UIProgressView *prog;
    prog = (UIProgressView *)[cell viewWithTag:3];
    prog.progress = 0.2*indexPath.row;
    
    cell.imageView.image = [UIImage imageNamed:@"car.jpg"];
    
    if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //create UILongPressGestureRecognizer
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionLongPressGesture:)];
    longPressGestureRecognizer.minimumPressDuration = 0.8;
    [cell addGestureRecognizer:longPressGestureRecognizer];
    ///////
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TodoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    

    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



@end
