//
//  HomeViewModel.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import Foundation
import RxSwift
import RxAlamofire
import CoreData

class HomeViewModel{
    
    
    private let useCase: FetchUpcomingUseCaseImpl
    private let disposeBag = DisposeBag()
        
    let items = PublishSubject<[Guide]>()
    
    let localItems = PublishSubject<[GuideData]>()
    
        let error = PublishSubject<Error>()
        let isLoading = BehaviorSubject<Bool>(value: false)
        
        init(useCase: FetchUpcomingUseCaseImpl) {
            self.useCase = useCase
           
            fetchUpcoming()
            fetchItems()
        }
    
    
    
    
    func fetchItems(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
                let fetchRequest = GuideData.fetchRequest()
                do {
                    let items = try context.fetch(fetchRequest) as! [GuideData]
                    localItems.onNext(items )
                    localItems.disposed(by: disposeBag)
                }catch{
                    
                }
        }

    private func fetchUpcoming() {
        
        isLoading.onNext(true)
        useCase.fetchUpcoming()
            .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] items in
                    self?.isLoading.onNext(false)
                    
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                       
                    for item in items {
                        let entity = NSEntityDescription.entity(forEntityName: "GuideData", in: context)
                        
                        let newEntity = GuideData(entity: entity!, insertInto: context)
                        newEntity.fromGuide(guide: item)
                        
                    }
                    do {
                        try context.save()
                    }catch{
                        
                    }
                    
                    self?.items.onNext(items)
                    
                    
                }, onError: { [weak self] error in
                    self?.isLoading.onNext(false)
                    self?.error.onNext(error)
                })
                .disposed(by: disposeBag)
        }

}
