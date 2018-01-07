//
//  FitReader.m
//  Test
//
//  Created by Jelle Vandebeeck on 07/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FitReader.h"
#import "FitRecord.h"

#include <fstream>
#include <iostream>
#include <iosfwd>

#include "fit_decode.hpp"
#include "fit_mesg_broadcaster.hpp"
#include "fit_developer_field_description.hpp"

#include <list>
#include "fit_record_mesg_listener.hpp"

class RecordListener: fit::RecordMesgListener {
public:
    std::list<fit::RecordMesg> records;
    
    void PrintValues(const fit::FieldBase& field)
    {
        for (FIT_UINT8 j=0; j< (FIT_UINT8)field.GetNumValues(); j++)
        {
            switch (field.GetType())
            {
                    // Get float 64 values for numeric types to receive values that have
                    // their scale and offset properly applied.
                case FIT_BASE_TYPE_ENUM:
                case FIT_BASE_TYPE_BYTE:
                case FIT_BASE_TYPE_SINT8:
                case FIT_BASE_TYPE_UINT8:
                case FIT_BASE_TYPE_SINT16:
                case FIT_BASE_TYPE_UINT16:
                case FIT_BASE_TYPE_SINT32:
                case FIT_BASE_TYPE_UINT32:
                case FIT_BASE_TYPE_SINT64:
                case FIT_BASE_TYPE_UINT64:
                case FIT_BASE_TYPE_UINT8Z:
                case FIT_BASE_TYPE_UINT16Z:
                case FIT_BASE_TYPE_UINT32Z:
                case FIT_BASE_TYPE_UINT64Z:
                case FIT_BASE_TYPE_FLOAT32:
                case FIT_BASE_TYPE_FLOAT64:
                    NSLog(@"👀 Read float value %f", field.GetFLOAT64Value(j));
                    break;
                case FIT_BASE_TYPE_STRING:
                    FIT_WSTRING rawString = field.GetSTRINGValue(j);
                    NSString *value = [[NSString alloc] initWithBytes:rawString.data() length:rawString.size() * sizeof(wchar_t) encoding:NSUTF32LittleEndianStringEncoding];
                    NSLog(@"👀 Read string value %@", value);
                    break;
            }
        }
    }
    
    void OnMesg(fit::RecordMesg& mesg)
    {
        records.push_back(mesg);
        
//        NSLog(@"👀 Number of fields found %i", mesg.GetNumFields());
        
//        for (FIT_UINT16 i = 0; i < (FIT_UINT16)mesg.GetNumFields(); i++)
//        {
//            fit::Field* field = mesg.GetFieldByIndex(i);
//            NSLog(@"   Field %d (%s) has %d value(s)", i, field->GetName().c_str(), field->GetNumValues());
//
//            PrintValues(*field);
//        }
//
//        for (auto devField : mesg.GetDeveloperFields())
//        {
//            NSLog(@"Developer Field(%s) has %d value(s)", devField.GetName().c_str(), devField.GetNumValues());
//            PrintValues(devField);
//        }
    }
};

@interface FitReader ()

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSMutableArray<FitRecord *> *records;

@end

@implementation FitReader

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        self.path = path;
        NSLog(@"📦 Opening file at path %@", self.path);
    }
    return self;
}

- (void)read {
    
    FILE *somefile;
    if ((somefile = fopen([self.path UTF8String], "rb")) == NULL) {
        NSLog(@"🔥 Error opening file");
    }
    
    self.records = [NSMutableArray new];

    fit::Decode decode;
    std::fstream file;
    RecordListener listener;
    
        NSLog(@"📦 Start opening file");
        file.open([self.path UTF8String], std::ios::in | std::ios::binary);
        if (!file.is_open()) { NSLog(@"🔥 Error opening file"); }
    
        NSLog(@"📦 Checking for FIT");
        if (!decode.IsFIT(file)) { NSLog(@"🔥 FIT check failed"); }
        
        NSLog(@"📦 Checking for integrity");
        if (!decode.CheckIntegrity(file)) { NSLog(@"🔥 Integrity check failed"); }
        
        
        
        
        
        // self.decode = [[FitDecode alloc] init];

        // Setup the listeners.
        fit::MesgBroadcaster broadcaster = fit::MesgBroadcaster();
        broadcaster.AddListener((fit::RecordMesgListener &)listener);
        NSLog(@"📦 Start listening file");
    

    @try {
//        decode.Read(file, &listener);
        decode.Read(file, broadcaster);
//        decode.Read(file, broadcaster, listener);
        
//        [self.decode IsFit:file];
//        [self.decode CheckIntegrity:file];
//        [self.decode Read:file withListener:&broadcaster andDefListener:NULL];
//        fclose(file);
    }
    @catch (NSException *exception) {
        NSLog(@"🔥 Error decoding file %@", [exception reason]);
    }
    @finally {
        std::list<fit::RecordMesg> rawRecords = listener.records;
        
        double conversion = 180.0 / pow(2, 31);
        for (fit::RecordMesg rawRecord : rawRecords) {
            FitRecord *record = [FitRecord new];
            
            ::fit::int32_t rawLatitude = rawRecord.GetPositionLat();
            double convertedLatitude = rawLatitude * conversion;
            
            ::fit::int32_t rawLongitude = rawRecord.GetPositionLong();
            double convertedLongitude = rawLongitude * conversion;
            
            record.coordindate = CLLocationCoordinate2DMake(convertedLatitude, convertedLongitude);
            [self.records addObject:record];
        }
        
        NSLog(@"📦 Record count %lu", (unsigned long)[self.records count]);
        NSLog(@"📦 Finished decoding file");
    }
}

@end
