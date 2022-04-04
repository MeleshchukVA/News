//
//  PersistenceManager.swift
//  News
//
//  Created by Владимир Мелещук on 04.04.2022.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard

    enum Keys { static let bookmarks = "bookmarks" }

    static func updateWith(bookmark: Article, actionType: PersistenceActionType, completed: @escaping (NewsError?) -> Void) {
        retrieveBookmarks { result in
            switch result {
            case .success(let bookmarks):
                var retrievedBookmarks = bookmarks
                
                switch actionType {
                case .add:
                    guard !retrievedBookmarks.contains(bookmark) else {
                        completed(.alreadyInBookmarks)
                        return
                    }

                    retrievedBookmarks.append(bookmark)

                case .remove:
                    retrievedBookmarks.removeAll { $0.title == bookmark.title }
                }

                completed(save(bookmarks: retrievedBookmarks))

            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retrieveBookmarks(completed: @escaping (Result<[Article], NewsError>) -> Void) {
        guard let bookmarksData = defaults.object(forKey: Keys.bookmarks) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let bookmarks = try decoder.decode([Article].self, from: bookmarksData)
            completed(.success(bookmarks))
        } catch {
            completed(.failure(.unableAddToBookmarks))
        }
    }

    static func save(bookmarks: [Article]) -> NewsError? {
        do {
            let encoder = JSONEncoder()
            let encodedBookmarks = try encoder.encode(bookmarks)
            defaults.set(encodedBookmarks, forKey: Keys.bookmarks)
            return nil
        } catch {
            return .unableAddToBookmarks
        }
    }
}
