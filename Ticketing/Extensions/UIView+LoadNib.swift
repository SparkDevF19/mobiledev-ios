//
//  UIView+LoadNib.swift
//  Ticketing
//
//  Created by Ung Hour on 10/31/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
}
