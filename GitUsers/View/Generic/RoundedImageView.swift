//
//  RoundedImageView.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import UIKit

class RoundedImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
    }
}
