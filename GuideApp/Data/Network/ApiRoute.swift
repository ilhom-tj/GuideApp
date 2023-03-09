//
//  ApiRoute.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import Foundation
import Alamofire
enum ApiRouter : URLRequestConvertible{
    
    
    case upcomingGuides
    private var path: String {
            switch self {
            case .upcomingGuides :
                return "/upcomingGuides/"
            }
        }
    private var method: HTTPMethod {
            switch self {
            case .upcomingGuides :
                return .get
            }
        }
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.ProductionServer.baseURL.asURL()
                
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
                
                // HTTP Method
        urlRequest.httpMethod = method.rawValue
                
                // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
         
                
        return urlRequest
    }
}
