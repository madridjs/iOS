//
//  MADEventosVC.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 06/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "MADBackend.h"
#import "ER9AppDelegate.h"
#import "MADEventoViewCell.h"
#import "MADEventoProxViewCell.h"
#import "MADUtil.h"
#import "MADEventoCalendario.h"


@interface MADEventosVC : UICollectionViewController <UIActionSheetDelegate>


@property MADBackend *backend;
@property (nonatomic) MADEventoCalendario *calendario;

@end
