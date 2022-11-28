//
//  NewsModel.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import Foundation

struct News: Codable {
    
    let articles: [Article]
}

struct Article: Codable, Hashable {
    
    var author: String?
    let title: String
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
