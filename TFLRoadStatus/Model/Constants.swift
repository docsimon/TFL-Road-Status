//
//  Constants.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Client {
        static let baseUrl = "https://api.tfl.gov.uk"
        static let basePath = "/Road"
    }
    
    // MARK: API Parameter Keys
    struct TflParameterKeys {
        static let AppID = "app_id"
        static let AppKey = "app_key"
    }
    
    // MARK: API Parameter Values
    struct TflParameterValues {
        static let AppID = "<YOUR application ID>"
        static let AppKey = "<YOUR application key>"
    }
    
    // MARK:  Errors
    struct Errors {
        static let clientErrorTitle = "Client Error"
        static let networkErrorTitle = "Network Error"
        static let errorDataTitle = "Data Error"
        static let errorParsingData = "Error parsing data"
        static let jsonHandlerErrorTitle = "Json handler Error"
        static let jsonHandlerErrorMsg = "The Json handler is nil"
        static let urlRequestErrorTitle = "URLRequest Error"
        static let urlRequestErrorMsg = "URLRequest is empty"
        static let urlPageErrorTitle = "No url"
        static let urlPageErrorMsg = "No web page availble for this event"
        static let urlCreationErrorMsg = "Cannot create the url"
        static let sessionErrorTitle =  "Authentication Failed"
        static let sessionErrorMsg = "Impossible fetching session url"
        static let statusCodeUnknownMsg = "Status code unknown"
        static let errorReceivingData = "Error receiving data"
        static let errorEmptyFieldTitle = "Empty Field"
        static let errorEmptyFieldMsg = "The search field can't be empty"

        
        struct HttpError {
            static let http400 = "Bad Request – Input validation failed."
            static let http403 = "Forbidden – The API Key was not supplied, or it was invalid, or it is not authorized to access the service."
            static let http404 = "Code 404: Not Found"
            static let http408 =  "Code 408: Request Timeout"
            static let http410 = "Gone – the session has expired. A new session must be created."
            static let http429 =  "Too Many Requests – There have been too many requests."
            static let http500 = "Server Error – An internal server error has occurred."
            static let http502 =  "Code 502: Bad Gateway"
            static let http503 = "Code 503: Service Unavailable"
            static let http504 =  "Code 504: Gateway Timeout"
            static let generic =  "Generic network error"
        }
    }
    // MARK: Error buttons
    struct UIViews {
        struct  ErrorView {
            static let dismissButton = "Dismiss"
            static let reloadButton = "Reload"
        }
    }
    
}
