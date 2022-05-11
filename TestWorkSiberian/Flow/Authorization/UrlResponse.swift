//
//  UrlResponse.swift
//  TestWorkSiberian
//
//  Created by Наташа on 08.05.2022.
//

import Foundation

struct UrlResponse: Codable {
    var characterId: Int
    var name: String
    var birthday: String
    var nickname: String
    var img: String?
    var status: String
    var category: String
}
