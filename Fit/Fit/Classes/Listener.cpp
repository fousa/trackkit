//
//  Listener.cpp
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#include <stdio.h>
#include <list>

#include "fit_record_mesg_listener.hpp"
#include "fit_lap_mesg_listener.hpp"
#include "fit_activity_mesg_listener.hpp"

class Listener: fit::RecordMesgListener, fit::LapMesgListener, fit::ActivityMesgListener {
public:
    std::list<fit::ActivityMesg> activities;
    std::list<fit::RecordMesg> records;
    std::list<fit::LapMesg> laps;
    
    void OnMesg(fit::ActivityMesg& mesg) {
        activities.push_back(mesg);
    }
    
    void OnMesg(fit::LapMesg& mesg) {
        laps.push_back(mesg);
    }
    
    void OnMesg(fit::RecordMesg& mesg) {
        records.push_back(mesg);
    }
    
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
////                    NSLog(@"👀 Read float value %f", field.GetFLOAT64Value(j));
//                    break;
//                case FIT_BASE_TYPE_STRING:
////                    FIT_WSTRING rawString = field.GetSTRINGValue(j);
////                    NSString *value = [[NSString alloc] initWithBytes:rawString.data() length:rawString.size() * sizeof(wchar_t) encoding:NSUTF32LittleEndianStringEncoding];
////                    NSLog(@"👀 Read string value %@", value);
//                    break;
//            }
//        }
//    }
};
