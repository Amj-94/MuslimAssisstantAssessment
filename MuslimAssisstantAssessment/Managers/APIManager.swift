//
//  APIManager.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/20/21.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    let baseURL = "https://covid-193.p.rapidapi.com/"
    
    func getCountries(completion: @escaping(Result<[String], Error>) -> Void) {
        guard let url = URL(string: baseURL + "countries") else {
            completion(.failure(NetWorkManagerError.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "x-rapidapi-host" : rapidapiHost,
            "x-rapidapi-key" : apiKey,
        ]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetWorkManagerError.badResponse))
                    return
                }
                switch unwrappedResponse.statusCode {
                case 200 ..< 300 :
                    print("Success")
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                if let unwrappedData = data{
                    do {
                        if let json = try? JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String : Any] {
                            let countries = json["response"] as! [String]
                            completion(.success(countries))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                                completion(.failure(errorResponse))
                        }
                    } catch let decodingerr {
                        completion(.failure(decodingerr))
                    }
                }
                
            }
        }.resume()
    }
    
    func getCountryDetails(countryName: String, completion: @escaping(Result<CountryStatistics, Error>) -> Void) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "covid-193.p.rapidapi.com"
        components.path = "/statistics"
        let queryItemCountry = URLQueryItem(name: "country", value: countryName)
        components.queryItems = [queryItemCountry]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "x-rapidapi-host" : rapidapiHost,
            "x-rapidapi-key" : apiKey,
        ]
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetWorkManagerError.badResponse))
                    return
                }
                switch unwrappedResponse.statusCode {
                case 200 ..< 300 :
                    print("Success")
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                if let unwrappedData = data{
                    do {
                        if let json = try? JSONDecoder().decode(CountryStatistics.self, from: unwrappedData) {
                            completion(.success(json))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                        }
                    } catch let decodingerr {
                        completion(.failure(decodingerr))
                    }
                }
                
            }
        }.resume()
        
        
    }
}



enum NetWorkManagerError: Error {
    case badURL
    case badResponse
    case badEncoding
}

struct ErrorResponse: Decodable, LocalizedError{
    let reason: String
    var errorDescription: String?{
        return reason
    }
}
