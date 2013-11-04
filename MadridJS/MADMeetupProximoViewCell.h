//
//  MADMeetupProximoViewCell.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 03/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADMeetupProximoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *evento_prox;
@property (weak, nonatomic) IBOutlet UILabel *fecha;
@property (weak, nonatomic) IBOutlet UILabel *direccion;
@property (weak, nonatomic) IBOutlet UILabel *descripcion;

@end
