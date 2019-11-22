//
//  UIFont+PreferredFont&Weight.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/21/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

extension UIFont {
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
