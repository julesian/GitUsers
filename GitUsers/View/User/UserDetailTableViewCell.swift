//
//  UserDetailTableViewCell.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/28/21.
//

import Foundation

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    enum Constants {
        static let identifier = "UserDetailTableViewCell"
    }
    
    public func setup(name: String, value: String) {
        titlelabel.text = name
        valueLabel.text = value
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
