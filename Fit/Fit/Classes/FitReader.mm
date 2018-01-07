//
//  FitReader.m
//  Test
//
//  Created by Jelle Vandebeeck on 07/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#import "FitReader.h"

#import "FitDecode.h"
#include "fit_mesg_broadcaster.hpp"

#include "fit_record_mesg_listener.hpp"

class RecordListener: fit::RecordMesgListener {
public:
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
        NSLog(@"👀 Number of fields found %i", mesg.GetNumFields());
        
        for (FIT_UINT16 i = 0; i < (FIT_UINT16)mesg.GetNumFields(); i++)
        {
            fit::Field* field = mesg.GetFieldByIndex(i);
            NSLog(@"   Field %d (%s) has %d value(s)", i, field->GetName().c_str(), field->GetNumValues());

            PrintValues(*field);
        }

        for (auto devField : mesg.GetDeveloperFields())
        {
            NSLog(@"Developer Field(%s) has %d value(s)", devField.GetName().c_str(), devField.GetNumValues());
            PrintValues(devField);
        }
    }
};

@interface FitReader ()

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) FitDecode *decode;

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
    NSLog(@"📦 Start reading file");
    FILE *file;
    if ((file = fopen([self.path UTF8String], "rb")) == NULL) {
        NSLog(@"🔥 Error opening file");
    }

    @try {
        NSLog(@"📦 Start decoding file");
        self.decode = [[FitDecode alloc] init];

        // Setup the listeners.
        RecordListener listener;
        fit::MesgBroadcaster broadcaster = fit::MesgBroadcaster();
        broadcaster.AddListener((fit::RecordMesgListener &)listener);
        
        [self.decode IsFit:file];
        [self.decode CheckIntegrity:file];
        [self.decode Read:file withListener:&broadcaster andDefListener:NULL];
        fclose(file);
    }
    @catch (NSException *exception) {
        NSLog(@"🔥 Error decoding file %@", [exception reason]);
    }
    @finally {
        NSLog(@"📦 Finished decoding file");
    }
}

@end
