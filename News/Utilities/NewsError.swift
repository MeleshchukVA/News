//
//  NewsError.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import Foundation

enum NewsError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponce = "Invalid responce from the server. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
    case unableAddToBookmarks = "There was an error added this article. Please try again."
    case alreadyInBookmarks = "You're already added this bookmark."
}

