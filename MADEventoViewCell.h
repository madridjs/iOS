//
//  MADEventoViewCell.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 06/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADEventoViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventoNombre;
@property (weak, nonatomic) IBOutlet UILabel *javascripter;
@property (weak, nonatomic) IBOutlet UILabel *estado;
@property (weak, nonatomic) IBOutlet UILabel *fecha;

@end
