//
//  BaseLabel.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

class BaseLabel: UILabel{
    var type: LabelType
    
    init(type: LabelType){
        self.type = type
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        textAlignment = type.textAlignment
        textColor = type.textColor
        font = type.font
    }
}
