//
//  MatchSectionHeaderView.swift
//  penca
//
//  Created by Lucas Bloise on 29/09/2022.
//

import UIKit

class MatchSectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak private var sectionLabel: UILabel!
    static let identifier = "MatchSectionHeader"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure( sectionTitle: String) {
        sectionLabel.text =  getDate(stringDate: sectionTitle)
    }
    
    func getDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_AR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: stringDate)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date!)
        let finalDate = calendar.date(from: components)
        dateFormatter.dateFormat = "EEEE MM/dd"
        
        return dateFormatter.string(from: finalDate!).capitalized
    }
}
