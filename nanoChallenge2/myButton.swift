//
//  myButton.swift
//  nanoChallenge2
//
//  Created by Golden Kevin on 19/09/19.
//  Copyright © 2019 Golden Kevin. All rights reserved.
//

import UIKit

class myButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
    
}
