//
//  Tag.swift
//  CapsuleTags
//
//  Created by Cecilia Chen on 9/7/23.
//

import Foundation

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
}
