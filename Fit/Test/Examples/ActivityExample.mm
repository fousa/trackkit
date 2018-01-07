//
//  ActivityExample.m
//  Test
//
//  Created by Jelle Vandebeeck on 07/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "ActivityExample.h"

#import <Fit/Fit.h>

//#include "fit_record_mesg_listener.hpp"


//class RecordListener: fit::MesgListener
//{
//
//
//
//};

@interface ActivityExample ()

@property (nonatomic, strong) FitReader *reader;

@end

@implementation ActivityExample

- (instancetype)initWithFilename:(NSString *)filename {
    if (self = [super init]) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:filename ofType:@"fit"];
        self.reader = [[FitReader alloc] initWithPath:filepath];
    }
    return self;
}

- (void)read {
    [self.reader read];
    
//    FILE *file;
//    if ((file = fopen([self.filepath UTF8String], "rb")) == NULL) {
//        NSLog(@"🔥 Error opening file");
//    }
//
//    @try {
//        self.decoder = [[FitDecode alloc] init];
    
        
//        ActivityListener listener;
//        fit::MesgBroadcaster mesgBroadcaster = fit::MesgBroadcaster();
//        mesgBroadcaster.AddListener((fit::FileIdMesgListener &)listener);
//        mesgBroadcaster.AddListener((fit::MesgListener &)listener);
//        [super.fd IsFit:file];
//        [super.fd CheckIntegrity:file];
//        [super.fd Read:file withListener:&mesgBroadcaster andDefListener:NULL];
//        fclose(file);
//        file = NULL;
//    }
//    @catch (NSException *exception) {
//        NSLog(@"🔥 Error reading file %@", [exception reason]);
//    }
}

@end

//public:
//    void OnMesg(fit::FileIdMesg& mesg)
//    {
//        NSLog(@"Type: %d", mesg.GetType());
//        NSLog(@"Manufacturer: %d", mesg.GetManufacturer());
//        NSLog(@"Product: %d", mesg.GetProduct());
//        NSLog(@"SerialNumber: %d", mesg.GetSerialNumber());
//    }
//
//    void PrintValues(const fit::FieldBase& field)
//    {
//        for (FIT_UINT8 j=0; j< (FIT_UINT8)field.GetNumValues(); j++)
//        {
//            switch (field.GetType())
//            {
//                    // Get float 64 values for numeric types to receive values that have
//                    // their scale and offset properly applied.
//                case FIT_BASE_TYPE_ENUM:
//                case FIT_BASE_TYPE_BYTE:
//                case FIT_BASE_TYPE_SINT8:
//                case FIT_BASE_TYPE_UINT8:
//                case FIT_BASE_TYPE_SINT16:
//                case FIT_BASE_TYPE_UINT16:
//                case FIT_BASE_TYPE_SINT32:
//                case FIT_BASE_TYPE_UINT32:
//                case FIT_BASE_TYPE_SINT64:
//                case FIT_BASE_TYPE_UINT64:
//                case FIT_BASE_TYPE_UINT8Z:
//                case FIT_BASE_TYPE_UINT16Z:
//                case FIT_BASE_TYPE_UINT32Z:
//                case FIT_BASE_TYPE_UINT64Z:
//                case FIT_BASE_TYPE_FLOAT32:
//                case FIT_BASE_TYPE_FLOAT64:
//                    NSLog(@"%f", field.GetFLOAT64Value(j));
//                    break;
//                case FIT_BASE_TYPE_STRING:
//                    NSLog(@"%@", [Example stringForWString:field.GetSTRINGValue(j)]);
//                    break;
//                default:
//                    break;
//            }
//        }
//    }
//
//    void OnMesg(fit::Mesg& mesg)
//    {
//        NSLog(@"New Mesg: %s. It has %d field(s) and %d developer field(s).", mesg.GetName().c_str(), mesg.GetNumFields(), mesg.GetNumDevFields());
//
//        for (FIT_UINT16 i = 0; i < (FIT_UINT16)mesg.GetNumFields(); i++)
//        {
//            fit::Field* field = mesg.GetFieldByIndex(i);
//            NSLog(@"   Field %d (%s) has %d value(s)", i, field->GetName().c_str(), field->GetNumValues());
//            PrintValues(*field);
//        }
//
//        for (auto devField : mesg.GetDeveloperFields())
//        {
//            NSLog(@"Developer Field(%s) has %d value(s)", devField.GetName().c_str(), devField.GetNumValues());
//            PrintValues(devField);
//        }
//    }
//};

