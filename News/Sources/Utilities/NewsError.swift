//
//  NewsError.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import Foundation

enum NewsError: String, Error {
    
    case unableToComplete = "Невозможно завершить ваш запрос. Проверьте подключение к сети интернет."
    case invalidResponce = "Ошибка соединения с сервером. Попробуйте еще раз."
    case invalidData = "Некорректные данные от сервера. Попробуйте еще раз."
    case unableAddToBookmarks = "Ошибка при добавлении в закладки. Попробуйте еще раз."
    case alreadyInBookmarks = "Вы уже добавили эту новость в закладки."
}
