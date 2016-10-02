//
//  Person+TCX.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 30/09/2016.
//
//

import AEXML

extension Person: TCXable {
    
    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        self.init()
        
        name       <~ element["Name"]
        build      <~ Build(tcx: element["Build"])
        language   <~ element["LangID"]
        partNumber <~ element["PartNumber"]
    }
    
}
