//
//  NetworkService.swift
//  TestWorkSiberian
//
//  Created by Наташа on 11.05.2022.
//

import Foundation

class NetworkService {
    let urlBreakingBadApi = "https://www.breakingbadapi.com/api/characters/"
    func request(urlString: String, completion: @escaping (Result<[BreakingBadCharacters],Error>)-> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let usersInfo = try JSONDecoder().decode([BreakingBadCharacters].self, from: data)
                    completion(.success(usersInfo))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
