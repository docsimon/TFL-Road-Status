//
//  DataModel.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation
// Data model for encoding/deconding json files and support data

struct ErrorData{
    let errorTitle: String
    let errorMsg: String
}

struct Road: Decodable {
    let displayName: String
    let statusSeverity: String
    let statusSeverityDescription: String
}
