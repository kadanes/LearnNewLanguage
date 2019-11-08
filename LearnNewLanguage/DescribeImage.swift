//
//  DescribeImage.swift
//  LearnNewLanguage
//
//  Created by Swati Sharma on 6/11/19.
//  Copyright © 2019 Ankur Lakhanpal. All rights reserved.
//
// JJ: 8/11/19 Changed structs naming to reflect Azure JSON naming of returned response

import Foundation

struct DescribeImage: Decodable {
    let categories: [Categories]?
    let requestId: String?
    let metadata: Metadata?
}

struct Categories: Decodable {
    let name: String?
    let score: Float?
}

struct Caption: Decodable {
    let text: String?
    let confidence: Float?
}

struct Metadata: Decodable{
    let width: Int?
    let height: Int?
    let format: String?
}

