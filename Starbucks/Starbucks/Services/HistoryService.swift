//
//  HistoryService.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 13.10.2024.
//

import Foundation

struct History: Codable {
    let transactions: [Transaction]
}


struct Transaction: Codable {
    let id: Int
    let type: String
    let amount: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case date = "processed_at"
    }
}

enum ServiceError: Error {
    case serverError
    case parsingError
}

struct HistoryService {
    static let shared = HistoryService()
    
    func fetchTransactions(completion: @escaping ((Result<[Transaction], Error>) -> Void)) {
        if let url = URL(string: "https://uwyg0quc7d.execute-api.us-west-2.amazonaws.com/prod/history") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                }
                
                guard let data = data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completion(Result.failure(ServiceError.serverError))
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let result = try decoder.decode(History.self, from: data)
                    DispatchQueue.main.async {
                        completion(Result.success(result.transactions))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(Result.failure(ServiceError.parsingError))
                    }
                }
            }.resume()
        }
        
    }
}
