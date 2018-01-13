//
//  Listener.cpp
//  Fit
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 Jelle Vandebeeck. All rights reserved.
//

#include <stdio.h>
#include <list>
#include <iostream>

#include "fit_record_mesg_listener.hpp"
#include "fit_lap_mesg_listener.hpp"
#include "fit_activity_mesg_listener.hpp"
#include "fit_segment_point_mesg_listener.hpp"

class Listener: fit::RecordMesgListener, fit::LapMesgListener, fit::ActivityMesgListener, fit::SegmentPointMesgListener {
public:
    
    #pragma mark - Activties
    
    std::list<fit::ActivityMesg> activities;
        void OnMesg(fit::ActivityMesg& mesg) {
        activities.push_back(mesg);
    }
    
    #pragma mark - Lap
    
    std::list<fit::LapMesg> laps;
    void OnMesg(fit::RecordMesg& mesg) {
        records.push_back(mesg);
    }
    
    #pragma mark - Records
    
    std::list<fit::RecordMesg> records;
    void OnMesg(fit::LapMesg& mesg) {
        laps.push_back(mesg);
    }
    
    #pragma mark - Segment Point
    
    std::list<fit::SegmentPointMesg> segmentPoints;
    void OnMesg(fit::SegmentPointMesg& mesg) {
        segmentPoints.push_back(mesg);
    }
    
};
