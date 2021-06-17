//
//  APIService.swift
//  MVPTest
//
//  Created by Bezdenezhnykh Sergey on 16.06.2021.
//

import Foundation

protocol APIServiceProtocol {
    func getMatch(completion: @escaping (Result<Match?, Error>) -> ())
    func getVideo(completion: @escaping (Result<VideoLinks?, Error>) -> ())
}

final class APIService: APIServiceProtocol {
    
    var urlSession = URLSession.shared
    
    func getMatch(completion: @escaping (Result<Match?, Error>) -> ()) {
        let urlSting = "https://api.instat.tv/test/data"
        guard let url = URL(string: urlSting) else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["proc": "get_match_info",
                                   "params": ["_p_sport": 1, "_p_match_id": 1724836]]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        request.httpBody = jsonData
        
        urlRequest(request, completion)
    }
    
    func getVideo(completion: @escaping (Result<VideoLinks?, Error>) -> ()) {
        let urlSting = "https://api.instat.tv/test/video-urls"
        guard let url = URL(string: urlSting) else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["match_id":1724836,"sport_id":1]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        request.httpBody = jsonData
        
        urlRequest(request, completion)
    }
    
    private func urlRequest<T: Codable>(_ request: URLRequest, _ completion: @escaping (Result< T, Error>) -> ()) {
        urlSession.dataTask(with: request) { data, responce, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "dataNilError", code: -100001, userInfo: nil)) )
                return
            }
            //print(String(data: data, encoding: .utf8))
            
            do {
                let decoder = JSONDecoder()
                completion(.success(try decoder.decode(T.self, from: data)))
                return
            } catch {
                print(error.localizedDescription)
                completion(.failure(NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil)))
                return
            }
        }
        .resume()
    }
    
    
}
