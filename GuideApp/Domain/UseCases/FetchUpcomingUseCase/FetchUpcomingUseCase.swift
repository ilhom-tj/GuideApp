//
//  FetchUpcomingUseCase.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire
import CoreData

class FetchUpcomingUseCaseImpl : IFetchUpcomingUseCase{
    
    func fetchUpcoming() -> Observable<[Guide]> {
        
        
        return RxAlamofire
            .data(.get, "https://guidebook.com/service/v2/upcomingGuides/")
            .map { response in
               
                do {
                    let items = try JSONDecoder().decode(GuideResponse.self, from: response)
                    return items.data ?? [Guide]()
                    
                } catch {
                    print(error)
                    return []
                }
            }
    }
    
   
    
    
}
