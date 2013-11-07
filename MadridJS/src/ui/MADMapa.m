//
//  MADMapa.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 06/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADMapa.h"

@implementation MADMapa
#define METERS_PER_MILE 1609.344

-(void)viewDidAppear:(BOOL)animated{

 
    NSLog(@"longitud %f",self.direccion.longitud);
     NSLog(@"latitude %f",self.direccion.latitud);
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.direccion.latitud;
    zoomLocation.longitude= self.direccion.longitud;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    
    MADAnotacion *annotation = [[MADAnotacion alloc] initWithName:self.direccion.local
                                                          address:self.direccion.direccion
                                                       coordinate:zoomLocation] ;
    [_mapa addAnnotation:annotation];
    
    [_mapa setRegion:viewRegion animated:YES];

}
@end
