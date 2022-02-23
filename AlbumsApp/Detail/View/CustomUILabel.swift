//
//  CustomUILabel.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 24.02.2022.
//

import UIKit

class CustomUILabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        
        self.text = "Artist Name"
        self.font = .systemFont(ofSize: 20)
        self.numberOfLines = 3
        self.textAlignment = .center
        self.sizeToFit()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
