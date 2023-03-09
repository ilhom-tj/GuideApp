//
//  IFetchUpcomingUseCase.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import Foundation
import RxSwift


protocol IFetchUpcomingUseCase {
    func fetchUpcoming() -> Observable<[Guide]>
}
