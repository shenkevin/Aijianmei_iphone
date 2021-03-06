//
//  SecondViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Myself_SettingsViewController.h"
#import "User.h"
#import "Citypicker.h"
#import "NumberPickViewController.h"


#define USER @"user"



@interface Myself_SettingsViewController ()


#pragma Image Picker Related
// this is just for copy
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
- (void)selectPhoto;
- (void)takePhoto;

@property (nonatomic, retain) UISwitch *airplaneModeSwitch;
@end


@implementation Myself_SettingsViewController
@synthesize airplaneModeSwitch = _airplaneModeSwitch;
@synthesize avatarButton =_avatarButton;
@synthesize user= _user;


- (id) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) return nil;
    
	self.title = NSLocalizedString(@"Settings", @"Settings");
    didSave =NO;
	return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


-(void)storeUserInfo{
    
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:USER];
    
}

-(void)didClickBackButton{
    
    if (didSave ==NO) {
     
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"保存修改" message:@"您当前修改数据没有保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        
        [av show];
    }
}


-(void)save{
    
    [self storeUserInfo];
     didSave =YES;

}

#pragma Image Picker Related

// this is just for copy
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil){
        
        self.user.avatarImage = image;
        [self.avatarButton setImage:self.user.avatarImage forState:UIControlStateNormal];
        [self storeUserInfo];
    }
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)selectPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self.navigationController presentModalViewController:picker animated:YES];
        [picker release];
        
    }
    
}

- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self.navigationController presentModalViewController:picker animated:YES];
        [picker release];
    }
    
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"编辑个人资料", @"Settings");
    
    didSave =NO;

    UIBarButtonItem *barButton  = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];

    
    
    
    UIViewController *vc  = [self.navigationController topViewController];
     UIBarButtonItem *back  = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(didClickBackButton)];
    
    vc.navigationItem.backBarButtonItem = back;
    [back release];
    
     
    
    self.airplaneModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    ////////add a section now 
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex)
     
     {
         //// add a row at the section one 
//         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//             staticContentCell.reuseIdentifier = @"UIControlCell";
//             cell.selectionStyle = UITableViewCellSelectionStyleNone;
//             
//             cell.textLabel.text = NSLocalizedString(@"Airplane Mode", @"Airplane Mode");
//             cell.imageView.image = [UIImage imageNamed:@"AirplaneMode"];
//             cell.accessoryView = self.airplaneModeSwitch;
//         }whenSelected:^(NSIndexPath *indexPath){
//         ///TODO
//             //    [self.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];
//
//         
//         }];
         
         //// add a row at the section one
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             staticContentCell.cellStyle = UITableViewCellStyleValue1;
             staticContentCell.reuseIdentifier = @"DetailTextCell";
             
             [staticContentCell setCellHeight:50];
             cell.detailTextLabel.text = NSLocalizedString(@"更换头像", @"iamtheinternet");

              self.avatarButton =[[UIButton alloc]initWithFrame:CGRectMake(17, 6, 40, 40)];
             
             
             [self.avatarButton setBackgroundColor:[UIColor clearColor]];
             [self.avatarButton setImage:self.user.avatarImage forState:UIControlStateNormal];
             
        
             [cell addSubview:self.avatarButton];
         } whenSelected:^(NSIndexPath *indexPath) {
             
             
             UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                                delegate:self
                                                       cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:@"照相"
                                                       otherButtonTitles:@"相册",nil];
             [share showFromTabBar:self.tabBarController.tabBar];
             [share release];
             
      }];
         
         //// add a row at the section one
//         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//             cell.textLabel.text = NSLocalizedString(@"Notifications", @"Notifications");
//             cell.imageView.image = [UIImage imageNamed:@"Notifications"];
//         } whenSelected:^(NSIndexPath *indexPath) {
////             [self.navigationController pushViewController:[[NotificationsViewController alloc] init] animated:YES];
//         }];
         
         //// add a row at the section one
//         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//             staticContentCell.cellStyle = UITableViewCellStyleValue1;
//             staticContentCell.reuseIdentifier = @"DetailTextCell";
//             
//             cell.textLabel.text = NSLocalizedString(@"Location Services", @"Location Services");
//             cell.detailTextLabel.text = NSLocalizedString(@"On", @"On");
//         } whenSelected:^(NSIndexPath *indexPath) {
//             //TODO			
//         }];
         
         
     }];
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        
        
              [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"性别", @"Sounds");
            
                  
            if ([self.user.gender isEqualToString:@"m"]) {
                      

                    
            }else{

                  
                  
                  }
                  
            UIButton *femaleButton  = [UIButton buttonWithType:UIButtonTypeCustom];
            [femaleButton setFrame:CGRectMake(120, 10, 25, 25)];
            [femaleButton setImage:[UIImage imageNamed:@"gender_on.png"]
                          forState:UIControlStateSelected];
            [femaleButton setImage:[UIImage imageNamed:@"gender_off.png"]
                                forState:UIControlStateNormal];

                  
            [cell addSubview:femaleButton];
                  
            UILabel *femaleLabel =[[UILabel alloc]initWithFrame:CGRectMake(90, 10, 30, 30)];
            [femaleLabel setText:@"女"];
            [femaleLabel setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:femaleLabel];
            [femaleLabel release];
                  
            
            UIButton *maleButton  = [UIButton buttonWithType:UIButtonTypeCustom];
            [maleButton setFrame:CGRectMake(210, 10, 25, 25)];
            [maleButton setImage:[UIImage imageNamed:@"gender_on.png"]
                                forState:UIControlEventTouchUpInside];
            [maleButton setImage:[UIImage imageNamed:@"gender_off.png"]
                                forState:UIControlStateNormal];

            [cell addSubview:maleButton];
                  
            UILabel *maleLabel =[[UILabel alloc]initWithFrame:CGRectMake(180, 10, 30, 30)];
            [maleLabel setText:@"男"];
            [maleLabel setBackgroundColor:[UIColor clearColor]];
                  
            [cell addSubview:maleLabel];
            [maleLabel release];
            
            
                  
            
            
//			cell.imageView.image = [UIImage imageNamed:@"Sounds"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            [staticContentCell setCellStyle:UITableViewCellStyleValue1];
            staticContentCell.reuseIdentifier  = @"DetailTextCell";
            
			cell.textLabel.text = NSLocalizedString(@"广东省广州市", @"Brightness");
            
            
            cell.detailTextLabel.text  = @"更换地区";
//			cell.imageView.image = [UIImage imageNamed:@"Brightness"];
		} whenSelected:^(NSIndexPath *indexPath) {
			
            Citypicker *cp  = [[Citypicker alloc]init];
            [self.navigationController pushViewController:cp animated:YES];
            [cp release];
            
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            [staticContentCell setCellStyle:UITableViewCellStyleValue1];
            staticContentCell.reuseIdentifier  = @"DetailTextCell";
			cell.textLabel.text = NSLocalizedString(@"身高", @"Wallpaper");
            cell.detailTextLabel.text =@"180cm";
                        
		} whenSelected:^(NSIndexPath *indexPath) {
            //TODO

            NumberPickViewController *cp  = [[NumberPickViewController alloc]init];
            [self.navigationController pushViewController:cp animated:YES];
            [cp release];
		}];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            [staticContentCell setCellStyle:UITableViewCellStyleValue1];
            staticContentCell.reuseIdentifier  = @"DetailTextCell";
			cell.textLabel.text = NSLocalizedString(@"体重", @"Wallpaper");
            cell.detailTextLabel.text =@"70kg";

		} whenSelected:^(NSIndexPath *indexPath) {
            
            //TODO
            NumberPickViewController *cp  = [[NumberPickViewController alloc]init];
            [self.navigationController pushViewController:cp animated:YES];
            [cp release];
		}];
        
        
	}];
	
    
    
	[self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        
        [section setTitle:@"心情短语"];
        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//            cell.textLabel.text = NSLocalizedString(@"General", @"General");
//			cell.imageView.image = [UIImage imageNamed:@"General"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
        
//        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"iCloud", @"iCloud");
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Mail, Contacts, Calendars", @"Mail, Contacts, Calendars");
//			cell.imageView.image = [UIImage imageNamed:@"Mail"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
//        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"", @"Twitter");
            [staticContentCell setCellStyle:UITableViewCellStyleValue1];
            [staticContentCell setCellHeight:100];
            
            UITextView *moodTextView = [[UITextView alloc]initWithFrame:CGRectMake(20,0, 280,100)];
            [moodTextView setBackgroundColor:[UIColor clearColor]];
            [moodTextView setText:@"今天我很开心哦。我和女朋友去健身啦！"];
            [moodTextView setFont:[UIFont fontWithName:nil size:30]];
            [cell addSubview:moodTextView];
            [moodTextView release];
                        
            
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Phone", @"Phone");
//			cell.imageView.image = [UIImage imageNamed:@"Phone"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"FaceTime", @"FaceTime");
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
//        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Safari", @"Safari");
//			cell.imageView.image = [UIImage imageNamed:@"Safari"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
//        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Messages", @"Messages");
//			cell.imageView.image = [UIImage imageNamed:@"Messages"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
//        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Music", @"Music");
//			cell.imageView.image = [UIImage imageNamed:@"Music"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Video", @"Video");
//			cell.imageView.image = [UIImage imageNamed:@"Video"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
//        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Photos", @"Photos");
//			cell.imageView.image = [UIImage imageNamed:@"Photos"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
//        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Notes", @"Notes");
//			cell.imageView.image = [UIImage imageNamed:@"Notes"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO
//		}];
//        
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"Store", @"Store");
//			cell.imageView.image = [UIImage imageNamed:@"AppStore"];
//		} whenSelected:^(NSIndexPath *indexPath) {
//			//TODO			
//		}];
        
        
        
	}];
}


#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"Button index :%d",buttonIndex);
                [self takePhoto];
            }
                break;
            case 1:
            {
                NSLog(@"Button index :%d",buttonIndex);
                [self  selectPhoto];

            }
                break;
            case 2:
                
            {
                NSLog(@"Button index :%d",buttonIndex);
            }
                break;
            default:
                break;
        }
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.airplaneModeSwitch = nil;
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
     
        NSLog(@"0");
    }else {
        NSLog(@"1");

    
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
