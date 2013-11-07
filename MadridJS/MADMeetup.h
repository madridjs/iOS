//
//  MADMeetup.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 02/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADMeetupDireccion.h"

@interface MADMeetup : NSObject

@property NSString              *identificador;
@property NSString              *nombre;

@property NSString              *descripcion;
@property NSString              *bio_charla;
@property NSString              *desc_charla;


@property NSDate                *creado;
@property NSDate                *actualizado;
@property NSDate                *tiempo;
@property NSURL                 *url;
@property NSString              *estado;
@property NSString              *how_to_find;
@property int                   personas;
@property MADMeetupDireccion    *direccion;


- (id)initWithDiccionario:(NSDictionary *)meetu_dicc;


@end
