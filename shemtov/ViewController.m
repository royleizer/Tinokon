//
//  ViewController.m
//  shemtov
//
//  Created by Roy Leizer on 09/05/2018.
//  Copyright © 2018 Roy Leizer. All rights reserved.
//

#import "ViewController.h"
#import "NamesViewController.h"
#import "DBManager.h"

@import Firebase;


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedNamesCount;
@property (nonatomic, strong) DBManager *dbManager2;
@property (weak, nonatomic) IBOutlet UITableView *table;
-(void) gotoMainScreen;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end



@implementation ViewController
NSArray *tableData2=nil;

SEL aSelector;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
/*
    self.ref = [[FIRDatabase database] reference];

    NSMutableDictionary * subitem =[[NSMutableDictionary alloc] init];
    [subitem setObject:@"1" forKey:@"NameID"];
    [subitem setObject:@"רועי" forKey:@"Name"];
    [subitem setObject:@"100" forKey:@"Rating"];
    [subitem setObject:@"0" forKey:@"IsUniSex"];
     [subitem setObject:@"0" forKey:@"Sex"];
    
    [[self.ref child:@"xname"]  setValue:subitem];
   
    
    [self.ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        
        for(NSString * key in postDict)
        {
             NSDictionary * subitem =postDict[key];
             NSLog(@"NameID : %@",[subitem objectForKey:@"NameID"]);
             NSLog(@"Name : %@",[subitem objectForKey:@"Name"]);
             NSLog(@"Rating : %@",[subitem objectForKey:@"Rating"]);
             NSLog(@"IsUniSex : %@",[subitem objectForKey:@"IsUniSex"]);
             NSLog(@"Sex : %@",[subitem objectForKey:@"Sex"]);
        }
    
    }];
    */
    
    
    self.dbManager2 = [[DBManager alloc] initWithDatabaseFilename:@"shemtovdic.sql"];
    
     NSString * viewquery =[NSString stringWithFormat:@"%@", @"select count(*) Total from t_names where Liked=1"];
    
    tableData2 = [[NSArray alloc] initWithArray:[self.dbManager2 loadDataFromDB:viewquery]];
    
    
    self.lblSelectedNamesCount.layer.masksToBounds = YES;
    self.lblSelectedNamesCount.layer.cornerRadius = 20;
    self.lblSelectedNamesCount.layer.borderColor = [UIColor blackColor].CGColor;
    self.lblSelectedNamesCount.layer.borderWidth = 1.0;
   
    
    aSelector=@selector(gotoMainScreen);
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    NSString * viewquery =[NSString stringWithFormat:@"%@", @"select count(*) Total from t_names where Liked=1"];
    
    tableData2 = [[NSArray alloc] initWithArray:[self.dbManager2 loadDataFromDB:viewquery]];
    
    NSString * val = [[tableData2 objectAtIndex:0] objectAtIndex:[self.dbManager2.arrColumnNames indexOfObject:@"Total"]];
    
    self.lblSelectedNamesCount.text = val;
}


- (IBAction)btnShowBoysView:(id)sender {
    [self showNamesByType:@"שמות לבנים" screenType:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnShowGirlsView:(id)sender {
      [self showNamesByType:@"שמות לבנות" screenType:1];
    
}
- (IBAction)btnShowSelectedNames:(id)sender {
     [self showNamesByType:@"שמות שאהבתי" screenType:2];
}

- (IBAction)btnShowPopularNames:(id)sender {
    
    [self showNamesByType:@"שמות נפוצים 2019" screenType:3];
}


- (IBAction)btnShowUnisexNames:(id)sender {
    
      [self showNamesByType:@"שמות יוניסקס" screenType:4];
}

- (IBAction)btnShowBibleNames:(id)sender {
    
      [self showNamesByType:@"שמות מהתנך" screenType:5];
}



-(void) gotoMainScreen
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) showNamesByType:(NSString *) screenName screenType:(int)stype
{
    NamesViewController *gview=[self.storyboard instantiateViewControllerWithIdentifier:@"v_names"];
    
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:gview];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"חזרה" style:UIBarButtonItemStylePlain  target:self  action:aSelector];
    item.enabled=true;
    
    
    gview.navigationItem.hidesBackButton=YES;
    gview.navigationItem.leftBarButtonItem=item;
    gview.navigationItem.title=@"חזרה";
    gview.sex = stype;
    
    [nav popViewControllerAnimated:YES];
    
    [gview setTitle:screenName];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

@end
