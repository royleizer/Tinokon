//
//  NamesViewController.m
//  shemtov
//
//  Created by Roy Leizer on 19/06/2018.
//  Copyright © 2018 Roy Leizer. All rights reserved.
//

#import "NamesViewController.h"
#import "DBManager.h"
#import "SimpleTableCellTableViewCell.h"
#import "ViewControllerWebview.h"
#import <MessageUI/MessageUI.h>



@interface NamesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) DBManager *dbManager;
@property (strong, nonatomic) FIRDatabaseReference *ref;


- (IBAction)Alef:(id)sender;
- (IBAction)Beit:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (weak, nonatomic) IBOutlet UIButton *btn9;
@property (weak, nonatomic) IBOutlet UIButton *btn10;
@property (weak, nonatomic) IBOutlet UIButton *btn11;
@property (weak, nonatomic) IBOutlet UIButton *btn12;
@property (weak, nonatomic) IBOutlet UIButton *btn13;
@property (weak, nonatomic) IBOutlet UIButton *btn14;
@property (weak, nonatomic) IBOutlet UIButton *btn15;
@property (weak, nonatomic) IBOutlet UIButton *btn16;
@property (weak, nonatomic) IBOutlet UIButton *btn17;
@property (weak, nonatomic) IBOutlet UIButton *btn18;
@property (weak, nonatomic) IBOutlet UIButton *btn19;
@property (weak, nonatomic) IBOutlet UIButton *btn20;
@property (weak, nonatomic) IBOutlet UIButton *btn21;
@property (weak, nonatomic) IBOutlet UIButton *btn22;

@end

@implementation NamesViewController
static NSString *simpleTableIdentifier = @"cell";
SimpleTableCellTableViewCell *cell=nil;
NSString *viewquery= nil;
NSArray *tableData;
int currentScreen=0;



NSIndexPath *currentCellIndexPath;


SEL bSelector;;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"shemtovdic.sql"];
    self.ref = [[FIRDatabase database] reference];
    
    
    
    
    self.table.delegate = self;
    self.table.dataSource = self;
    
    switch (self.sex) {
        case 0:
             viewquery =[NSString stringWithFormat:@"%@%d", @"select * from t_names where Sex=",self.sex];
             currentScreen=0;
             tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
             [self.table reloadData];
            break;
        case 1:
            viewquery =[NSString stringWithFormat:@"%@%d", @"select * from t_names where Sex=",self.sex];
            currentScreen=1;
            tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
            [self.table reloadData];
            break;
            
        case 2:
            viewquery =[NSString stringWithFormat:@"%@", @"select * from t_names where Liked=1"];
            currentScreen=2;
            tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
            [self.table reloadData];
            break;
            
        case 3:
            viewquery =[NSString stringWithFormat:@"%@", @"select * from t_names where PopularYear=2018 order by sex,PopularRating"];
            currentScreen=3;
            tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
            [self.table reloadData];
            break;
            
        case 4:
            viewquery =[NSString stringWithFormat:@"%@", @"select * from t_names where IsUnisex=1 order by Name"];
            currentScreen=4;
            tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
            [self.table reloadData];
            break;
        
        case 5:
            
            
            currentScreen=5;
            
            
            @try
            {
            
                [self.ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
                {
                    NSDictionary *postDict = snapshot.value;
                    NSString * selectedNamesIDs=@"";
                    
                    for(NSString * key in postDict)
                    {
                        NSDictionary * subitem =postDict[key];
                        NSString * srate =  [subitem objectForKey:@"Rating"];
                        int rating =[srate intValue];
                        if(rating>1)
                        {
                        NSLog(@"NameID : %@",[subitem objectForKey:@"NameID"]);
                        NSLog(@"Name : %@",[subitem objectForKey:@"Name"]);
                        NSLog(@"Rating : %@",[subitem objectForKey:@"Rating"]);
                        NSLog(@"IsUniSex : %@",[subitem objectForKey:@"IsUniSex"]);
                        NSLog(@"Sex : %@",[subitem objectForKey:@"Sex"]);
                        
                        selectedNamesIDs=[NSString stringWithFormat:@"%@%@%@",selectedNamesIDs,[subitem objectForKey:@"NameID"],@","];
                            
                        }
                    }
                    
                if([selectedNamesIDs length]>0)
                {
                    selectedNamesIDs = [selectedNamesIDs substringToIndex:[selectedNamesIDs length]-1];
                    
                    viewquery =[NSString stringWithFormat:@"%@%@%@", @"select * from t_names where ID in (", selectedNamesIDs , @")"];
                  
                    tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
                      [self.table reloadData];
                   
                }
                else
                {
                    tableData =nil;
                    [self.table reloadData];
                }
               
                   
                    
                }];
                
            }@catch (NSException *exception)
            {
                NSLog(@"Exception :%@",exception);
                
            }
            
            
            break;
            
            

    }
    
 
    
 
    //tableData = [NSArray arrayWithObjects:@"A",@"B",@"C" , nil];
    
     bSelector=@selector(gotoMainScreen);
    

        if(currentScreen==2)
        {
            [self enableLetters:false];
        }
        else
        {
            [self enableLetters:true];
        }

    

    
    
    
    
}

-(void) gotoMainScreen
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    cell = (SimpleTableCellTableViewCell*) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSString * val = [[tableData objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"Liked"]];
    
    
    
    int ret = [val integerValue];

    if(ret==1)
    {
        [cell setLikedState:YES];
    }
    else
    {
        [cell setLikedState:NO];
    }
    
    cell.cindex =indexPath;
    
   
    [cell.btnShowNameInfo addTarget:self  action:@selector(showNameInfoClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.lblName.text = [[tableData objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"Name"]];
    
    
    cell.btnSaveName.tag =indexPath.row;

    
    
    cell.btnShowNameInfo.tag=cell.lblName.text;
    
    NSString * gender =  [[tableData objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"Sex"]];
    
    int sex = [gender intValue];
    
    if(sex==0)
    {
      [cell.btnGender setImage:[UIImage imageNamed:@"baby-boy-icon.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnGender setImage:[UIImage imageNamed:@"baby-girl-icon.png"] forState:UIControlStateNormal];
    }
    
    
    
    return cell;
}


    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (SimpleTableCellTableViewCell*) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    currentCellIndexPath =  indexPath;
    
    
    if(cell!=nil)
    {
    NSString * rowid = [[tableData objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"ID"]];
    
    NSString * val = [[tableData objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"Liked"]];
        
    NSString * name = [[tableData objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"Name"]];
   
    NSString * isUnisex = [[tableData objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"IsUnisex"]];
        
    NSString * sex = [[tableData objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"Sex"]];
        
        
    bool liked = ![val boolValue];

        
    if(currentScreen==2)
    {
       
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"מחיקת שם"
                                     message: [NSString stringWithFormat:@"%@%@%@",@"האם ברצונך להסיר את השם ",name,@" מרשימת המועדפים?"] preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"כן"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                    //[Handle your yes please button action here]
                                    //[self clearAllData];
                                        NSString * upd_query=  [NSString stringWithFormat:@"%@%d%@%@",@"update t_names set liked=",liked,@" where ID=",rowid];
                                        NSLog(@"%@", upd_query);
                                        
                                        [self.dbManager executeQuery:upd_query];
                                        
                                        tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
                                        
                                        [self.table reloadData];
                                        
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"לא"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
      
        
    }
    else
    {
    NSString * upd_query=  [NSString stringWithFormat:@"%@%d%@%@",@"update t_names set liked=",liked,@" where ID=",rowid];
        NSLog(@"%@", upd_query);
        
    [self.dbManager executeQuery:upd_query];
        
      
        @try {
      
       // [self.ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
       
        [self.ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
        {
      
            NSDictionary * postDict   = snapshot.value;
            NSString * strRowID = [NSString stringWithFormat:@"%@",rowid];
            
            if([postDict isEqual:[NSNull null]])
            {
                NSMutableDictionary * subitemdeflt =[[NSMutableDictionary alloc] init];
                [subitemdeflt setObject:@"-1" forKey:@"NameID"];
                [subitemdeflt setObject:@"" forKey:@"Name"];
                [subitemdeflt setObject:@"0" forKey:@"Rating"];
                [subitemdeflt setObject:@"0" forKey:@"IsUniSex"];
                [subitemdeflt setObject:@"0" forKey:@"Sex"];
                
                [[self.ref child:@"-1"]  setValue:subitemdeflt];
                
            }
            
            else
    
            {
            
            NSMutableDictionary * subitem = [postDict objectForKey:strRowID];
            
                if(subitem==nil)
                {
                    //not exists,add new
                    NSMutableDictionary * subitemnew =[[NSMutableDictionary alloc] init];
                    [subitemnew setObject:strRowID forKey:@"NameID"];
                    [subitemnew setObject:name forKey:@"Name"];
                    [subitemnew setObject:@"1" forKey:@"Rating"];
                    [subitemnew setObject:isUnisex forKey:@"IsUniSex"];
                    [subitemnew setObject:sex forKey:@"Sex"];
                    
                    [[self.ref child:strRowID]  setValue:subitemnew];
                    
                }
                else
                {
                    //update ranking
                    
                    int rating =[ [subitem objectForKey:@"Rating"] intValue];
                    if(liked)
                        rating++;
                    else
                        if(rating>0)
                        {
                            rating--;
                        }
                    
                    NSString * srating = [NSString stringWithFormat:@"%d",rating];
                    
                    [subitem setObject:strRowID forKey:@"NameID"];
                    [subitem setObject:name forKey:@"Name"];
                    [subitem setObject:srating forKey:@"Rating"];
                    [subitem setObject:isUnisex forKey:@"IsUniSex"];
                    [subitem setObject:sex forKey:@"Sex"];
                    
                    [[self.ref child:strRowID]  setValue:subitem];
                    
                }
                
            }
                
            
        }];
            
        } @catch (NSException *exception) {
            NSLog(@"Exception: %@",exception);
        }
      
    }
        
   // Load the relevant data.
   tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
        
   [self.table reloadData];
        
      
    
        
    }
}


-(void)showNameInfoClick:(id)sender
{
    
    
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.google.com"]];
    request.timeoutInterval = 10;
    
    [NSURLConnection sendAsynchronousRequest:request queue:myQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
         NSLog(@"response status code: %ld, error status : %@", (long)[httpResponse statusCode], error.description);
         
         if ((long)[httpResponse statusCode] >= 200 && (long)[httpResponse statusCode]< 400)
         {
             // do stuff
             NSLog(@"Connected!");
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 UIButton * btnInfo = (UIButton *) sender;
                 
                 NSString * address = [NSString stringWithFormat:@"%@%@",@"https://cse.google.co.il/cse?cx=014954932560753297620:v_bmgcccg4e&q=",[btnInfo tag]];
                 
                 ViewControllerWebview *gview=[self.storyboard instantiateViewControllerWithIdentifier:@"v_web"];
                 
                 UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:gview];
                 
                 UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"חזרה" style:UIBarButtonItemStylePlain  target:self  action:bSelector];
                 item.enabled=true;
                 
                 gview.navigationItem.hidesBackButton=YES;
                 gview.navigationItem.leftBarButtonItem=item;
                 gview.navigationItem.title=@"חזרה";
                 gview.url=address;
                 
                 [nav popViewControllerAnimated:YES];
                 
                 [gview setTitle:@"מסך מידע"];
                 [self presentViewController:nav animated:YES completion:^{}];
                
             });
             
             
         }
         else
         {
             NSLog(@"Not connected!");
             
             NSString * msg = @"על מנת להציג את תוצאות החיפוש של השם המבוקש,יש להיות מחובר לאינטרנט";
             
             UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"אין חיבור לאינטרנט!"
                                                                            message:msg
                                                                     preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
             
             [alert addAction:defaultAction];
             [self presentViewController:alert animated:YES completion:nil];
         }
     }];

    
   
}



-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

-(void)updateTheList:(NSString *) letter
{
   
    switch (currentScreen) {
        case 0:
            viewquery =[NSString stringWithFormat:@"%@%d%@%@%@", @"select * from t_names where Sex=",self.sex,@" And Name like '",letter,@"%'"];
            break;
        case 1:
            viewquery =[NSString stringWithFormat:@"%@%d%@%@%@", @"select * from t_names where Sex=",self.sex,@" And Name like '",letter,@"%'"];
            break;
            
        case 2:
            viewquery =[NSString stringWithFormat:@"%@%@%@", @"select * from t_names where Liked=1 And Name like  '",letter,@"%'"];
          
            break;
            
        case 3:
            viewquery =[NSString stringWithFormat:@"%@%@%@%@", @"select * from t_names where PopularYear=2018 And Name like  '",letter,@"%'",@" order by sex,PopularRating"];
            break;
            
        case 4:
            viewquery =[NSString stringWithFormat:@"%@%@%@%@",
                     @"select * from t_names where IsUnisex=1 And Name like '",letter,@"%'", @" order by Name"];
            break;
            
        default:
            break;
    }
    
   
    
    // Load the relevant data.
    tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
    
    [self.table reloadData];
}

- (IBAction)Alef:(id)sender {
    [self updateTheList:@"א"];
}

- (IBAction)Beit:(id)sender {
     [self updateTheList:@"ב"];
}

- (IBAction)btnSetFavorite:(id)sender {

 //   currentCellIndexPath
        UIButton * btnSetFavorite = (UIButton *) sender;
        int rid=[btnSetFavorite tag];
        
        NSString * rowid = [[tableData objectAtIndex:rid] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"ID"]];
        
         NSString * val = [[tableData objectAtIndex:rid] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"Liked"]];
        
         bool liked = ![val boolValue];
        
    
    
    if(currentScreen==2)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"מחיקת שם"
                                     message: [NSString stringWithFormat:@"%@%@",@"האם ברצונך להסיר את השם ",@" מרשימת המועדפים?"] preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"כן"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //[Handle your yes please button action here]
                                        //[self clearAllData];
                                        NSString * upd_query=  [NSString stringWithFormat:@"%@%d%@%@",@"update t_names set liked=",liked,@" where ID=",rowid];
                                        NSLog(@"%@", upd_query);
                                        
                                        [self.dbManager executeQuery:upd_query];
                                        
                                        tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
                                        
                                        [self.table reloadData];
                                        
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"לא"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    }
    else
    {
    
        NSString * upd_query=  [NSString stringWithFormat:@"%@%d%@%@",@"update t_names set liked=",liked,@" where ID=",rowid];
        NSLog(@"%@", upd_query);
    
    
        [self.dbManager executeQuery:upd_query];
        
        tableData = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:viewquery]];
        
        [self.table reloadData];
         
  }
        
    
   

}


- (IBAction)Gimel:(id)sender {
      [self updateTheList:@"ג"];
}

- (IBAction)Dalet:(id)sender {
      [self updateTheList:@"ד"];
}

- (IBAction)Hey:(id)sender {
  [self updateTheList:@"ה"];
}


- (IBAction)Vav:(id)sender {
      [self updateTheList:@"ו"];
}

- (IBAction)Zein:(id)sender {
      [self updateTheList:@"ז"];
}

- (IBAction)Het:(id)sender {
      [self updateTheList:@"ח"];
}

- (IBAction)Tet:(id)sender {
      [self updateTheList:@"ט"];
}

- (IBAction)Yod:(id)sender {
      [self updateTheList:@"י"];
    
}

- (IBAction)Kaf:(id)sender {
      [self updateTheList:@"כ"];
}

- (IBAction)Lamed:(id)sender {
      [self updateTheList:@"ל"];
}

- (IBAction)Mem:(id)sender {
      [self updateTheList:@"מ"];
}

- (IBAction)NOn:(id)sender {
      [self updateTheList:@"נ"];
}

- (IBAction)Samech:(id)sender {
      [self updateTheList:@"ס"];
}

- (IBAction)Ain:(id)sender {
      [self updateTheList:@"ע"];
}

- (IBAction)Pey:(id)sender {
      [self updateTheList:@"פ"];
}

- (IBAction)Tzatdik:(id)sender {
      [self updateTheList:@"צ"];
}
- (IBAction)Resh:(id)sender {
      [self updateTheList:@"ר"];
}
- (IBAction)Shin:(id)sender {
      [self updateTheList:@"ש"];
}
- (IBAction)Taf:(id)sender {
      [self updateTheList:@"ת"];
}

- (IBAction)Kof:(id)sender {
    [self updateTheList:@"ק"];
}

-(void)enableLetters:(bool)isEnabled
{
   
          [_btn1 setEnabled:isEnabled];
          [_btn2 setEnabled:isEnabled];
          [_btn3 setEnabled:isEnabled];
          [_btn4 setEnabled:isEnabled];
          [_btn5 setEnabled:isEnabled];
          [_btn6 setEnabled:isEnabled];
          [_btn7 setEnabled:isEnabled];
          [_btn8 setEnabled:isEnabled];
          [_btn9 setEnabled:isEnabled];
          [_btn10 setEnabled:isEnabled];
          [_btn11 setEnabled:isEnabled];
          [_btn12 setEnabled:isEnabled];
          [_btn13 setEnabled:isEnabled];
          [_btn14 setEnabled:isEnabled];
          [_btn15 setEnabled:isEnabled];
          [_btn16 setEnabled:isEnabled];
          [_btn17 setEnabled:isEnabled];
          [_btn18 setEnabled:isEnabled];
          [_btn19 setEnabled:isEnabled];
          [_btn20 setEnabled:isEnabled];
          [_btn21 setEnabled:isEnabled];
          [_btn22 setEnabled:isEnabled];

}

- (IBAction)btnShareFavorits:(id)sender {
    
    @try {
        
    NSString * sqlFavNames =[NSString stringWithFormat:@"%@", @"select * from t_names where Liked=1"];
    NSArray * dataTable = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:sqlFavNames]];
    
        if([dataTable count]>0)
        {
            NSMutableString * favoriteNames=[[NSMutableString alloc] init];
        
            
            for(int i=0;i<[dataTable count];i++)
            {
             NSString * favname = [[dataTable objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"Name"]];
                [favoriteNames appendString:[NSString stringWithFormat:@"%@ ,",favname]];
            NSLog(@"%@",favname);
            }
            
          
            
            // for iPad: make the presentation a Popover
            

            // Email Content
            
        
            
            // To recipient where you want to send it
            
            NSArray *toRecipents = [NSArray arrayWithObject:@""];
            
            // MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            
            if ([MFMailComposeViewController canSendMail]) {
                
                picker.mailComposeDelegate = self;
                
                [picker setSubject:@"המלצה לשמות עבור הבייבי שלנו"];
                
                [picker setMessageBody:[NSString stringWithFormat:@"%@\r\n\r\n%@",favoriteNames,@"שיהיה המון מזל טוב. בברכה צוות תינוקי-מילון השמות המלא"]  isHTML:NO];
                
                [picker setToRecipients:toRecipents];
                
                [self presentViewController:picker animated:YES completion:NULL];
                
            }
            
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"ERROR %@", exception.reason);
    }
        
    }
    

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // This will be going to close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

    
    /*
    NSString * msg = @"YOUR MSG";
    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
    NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    } else {
        // Cannot open whatsapp
    }
     */


@end
