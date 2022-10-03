//
//  MatchTableViewCell.swift
//  penca
//
//  Created by Lucas Bloise on 28/09/2022.
//

import UIKit
import Kingfisher

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var matchStatusLabel: UILabel!
    @IBOutlet private weak var localGoalsLabel: UILabel!
    @IBOutlet private weak var awayGoalsLabel: UILabel!
    @IBOutlet private weak var localImageView: UIImageView!
    @IBOutlet private weak var awayImageView: UIImageView!
    @IBOutlet private weak var localNameLabel: UILabel!
    @IBOutlet private weak var awayNameLabel: UILabel!
    @IBOutlet private weak var seeMatchDetailsButton: UIButton!
    @IBOutlet private weak var statusBackgroundView: UIView!
    @IBOutlet private weak var statusLabelView: UIView!
    @IBOutlet private weak var borderView: UIView!
    static let identifier = "MatchTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
      // contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0))
        statusBackgroundView.layer.borderWidth = 1
        statusBackgroundView.layer.borderColor = UIColor(named: "pendingBackgroundColor")?.cgColor
        statusBackgroundView.layer.cornerRadius = 4
        statusLabelView.layer.cornerRadius = 4
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor(named: "pendingBackgroundColor")?.cgColor
        borderView.layer.cornerRadius = 4
        super.awakeFromNib()
    }
    @IBAction private func didTouchSeeDetails(_ sender: UIButton) {
        let detailsVC = StoryboardScene.Matches.matchDetailViewController.instantiate()
//        show(detailsVC, sender: nil)
    }
    
    func configure(match: Match) {
        self.matchStatusLabel.text = getMatchStatusText(status: match.getMatchStatus)
        setStatusColors(status: match.getMatchStatus)
        self.localNameLabel.text = match.homeTeamName
        self.awayNameLabel.text = match.awayTeamName
        if let homeTeamGoals = match.homeTeamGoals {
            self.localGoalsLabel.text = String(homeTeamGoals)
        } else {
            self.localGoalsLabel.text = "0"
        }
        
        if let awayTeamGoals = match.awayTeamGoals {
            self.awayGoalsLabel.text = String(awayTeamGoals)
        }else{
            self.awayGoalsLabel.text = "0"
        }
        
        localImageView.kf.setImage(with: URL(string: "https://\(match.homeTeamLogo)"))
        awayImageView.kf.setImage(with: URL(string: "https://\(match.awayTeamLogo)"))
        
        if match.status != "pending" {
            seeMatchDetailsButton.isHidden = false
        }
    }
    
    func setStatusColors(status: MatchStatus) {
        switch status {
        case .pending:
            self.statusBackgroundView.backgroundColor = UIColor(named: "pendingBackgroundColor")
            self.statusLabelView.backgroundColor = UIColor(named: "pendingLabelColor")
        case .correct:
            self.statusBackgroundView.backgroundColor = UIColor(named: "correctBackgroundColor")
            self.statusLabelView.backgroundColor = UIColor(named: "correctLabelColor")
        case .notPredicted:
            self.statusBackgroundView.backgroundColor = UIColor(named: "notPlayedBackground")
            self.statusLabelView.backgroundColor = UIColor(named: "notPlayedLabelColor")
        case .incorrect:
            self.statusBackgroundView.backgroundColor = UIColor(named: "incorrectBackgroundColor")
            self.statusLabelView.backgroundColor = UIColor(named: "incorrectLabelColor")
        }
    }
    
    func getMatchStatusText(status : MatchStatus) -> String {
        switch status {
        case .pending:
            return "Pendiente"
        case .correct:
            return "Acertado"
        case .notPredicted:
            return "Jugado s/resultado"
        case .incorrect:
            return "Errado"
        }
    }
    
    
    
}
