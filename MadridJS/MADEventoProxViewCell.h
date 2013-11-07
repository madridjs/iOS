//
//  MADEventoProxViewCell.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 07/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADEventoProxViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *evento_nombre;
@property (weak, nonatomic) IBOutlet UILabel *estado;
@property (weak, nonatomic) IBOutlet UILabel *fecha;
@property (weak, nonatomic) IBOutlet UILabel *javascripter;

@property (weak, nonatomic) IBOutlet UIButton *Informacion;
@property (weak, nonatomic) IBOutlet UIButton *Mapa;
@property (weak, nonatomic) IBOutlet UIButton *calendario;

@end
