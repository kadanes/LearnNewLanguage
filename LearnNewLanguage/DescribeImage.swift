//
//  DescribeImage.swift
//  LearnNewLanguage
//
//  Created by Swati Sharma on 6/11/19.
//  Copyright © 2019 Ankur Lakhanpal. All rights reserved.
//

import Foundation

struct DescribeImage: Codable {
    let description: Description?
    let requestId: String?
}

struct Description: Codable {
    let tags: [String]?
    let captions: [Caption]?
}

struct Caption: Codable {
    let text: String?
    let confidence: Float?
}
