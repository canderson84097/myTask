//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Chris Anderson on 11/13/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(for cell: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    weak var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(for: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(with task: Task) {
        primaryLabel.text = task.name
        if !task.isComplete {
            completeButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        } else {
            completeButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        }
    }
}
