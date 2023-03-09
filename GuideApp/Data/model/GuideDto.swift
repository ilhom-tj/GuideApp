//
//  GuideDto.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import CoreData
@objc(GuideData)
class GuideData : NSManagedObject {
    @NSManaged var name : String
    @NSManaged var startDate : String
    @NSManaged var endDate : String
    @NSManaged var icon : String
    @NSManaged var uri : String
    
    func fromGuide(guide : Guide){
        self.name = guide.name ?? ""
        self.startDate = guide.startDate
        self.endDate = guide.endDate ?? ""
        self.icon = guide.icon ?? ""
        self.uri = "https://guidebook.com" + (guide.url ?? "")
    }
}
