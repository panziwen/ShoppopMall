//
//  Feed.swift
//  SonicpMall
//
//  Created by 潘子文 on 2020/6/5.
//  Copyright © 2020 潘子文. All rights reserved.
//

import Foundation
struct Feed: Codable {
    var id: String
    var proid: String
    var proname: String
    var brand: String
    var price: String
    var pronub: String
    var type: String
    var remarks: String
    var photo: String
    var isempty:String
}

struct Media: Codable {
    var url: String
}
