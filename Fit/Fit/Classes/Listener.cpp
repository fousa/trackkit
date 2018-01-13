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
};
