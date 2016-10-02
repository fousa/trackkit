//
//  Build+TCX.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 02/10/2016.
//
//

import AEXML

extension Build: TCXable {

    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        self.init()

        version <~ Version(tcx: element["Version"])
    }

}
