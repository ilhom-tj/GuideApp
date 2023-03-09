//
//  GuideCell.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import UIKit

class GuideCell: UITableViewCell {

    @IBOutlet weak var guideImage: UIImageView!
    @IBOutlet weak var guideEnd: UILabel!
    @IBOutlet weak var guideStart: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    static let unib = UINib(nibName: "GuideCell", bundle: nil)
    static let id = "GuideCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setGuide(guide : GuideData){
        guideImage.sd_setImage(with: URL(string: guide.icon))
        guideLabel.text = guide.name
        guideStart.text = guide.startDate
        guideEnd.text = guide.endDate
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
