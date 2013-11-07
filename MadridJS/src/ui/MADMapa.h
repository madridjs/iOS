//
//  MADMapa.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 06/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MADMeetupDireccion.h"
#import "MADAnotacion.h"

@interface MADMapa : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) MADMeetupDireccion *direccion;
@end
