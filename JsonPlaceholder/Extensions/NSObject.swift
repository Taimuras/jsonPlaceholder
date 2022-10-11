//
//  NSObject.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

extension NSObject{
    @objc var screenWidth: CGFloat{
        UIScreen.main.bounds.width
    }
    
    @objc var screenHeight: CGFloat{
        UIScreen.main.bounds.height
    }
    
    var safeAreaBottomHeight: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    }
    
    var safeAreatopHeight: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.top
    }
}

