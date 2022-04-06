//
//  NetworkManager.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private let baseURL = "https://newsapi.org/v2/top-headlines?country=RU"
    private let apiKey = "e8dc364306c14351bda035195d810b5c"

    private init() {}
    
    // Функция загружает массив [Article] с учетом постраничной загрузки и декодирует его в JSON.
    func retrieveArticles(page: Int, completion: @escaping (Result<[Article], NewsError>) -> Void) {
        let endpoint = baseURL + "&page=\(page)" + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponce))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let result = try self.decoder.decode(News.self, from: data)
                completion(.success(result.articles))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
    
    // Функция загружает изображение с API
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)

        // Кэшируем картинки, чтобы не делать каждый раз запрос в сеть для них.
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            guard let self = self,
                  error == nil,
                  let responce = responce as? HTTPURLResponse, responce.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completed(nil)
                      return
                  }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }

        task.resume()
    }
    
    // Функция обращается в сеть для сохранения новости с помощью UserDefaults.
    func getArticleInfo(completed: @escaping (Result<[Article], NewsError>) -> Void) {
        let endpoint = baseURL + "&pageSize=100" + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponce))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let result = try self.decoder.decode(News.self, from: data)
                completed(.success(result.articles))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
