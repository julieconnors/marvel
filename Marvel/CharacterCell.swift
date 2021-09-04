//
//  CharacterCell.swift
//  Marvel
//
//  Created by Julie Connors on 9/4/21.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterName: UILabel!
    
    static let identifier = String(describing: CharacterCell.self)

    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterName.text = "Name"
    }
}
