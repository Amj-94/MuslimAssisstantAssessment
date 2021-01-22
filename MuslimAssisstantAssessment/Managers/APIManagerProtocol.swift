//
//  APIManagerProtocol.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/21/21.
//

import Foundation

protocol APIManagerProtocol {
    func getCountryDetails(countryName: String, completion: @escaping(Result<CountryStatistics, Error>) -> Void)
    
    func getCountries(completion: @escaping(Result<[String], Error>) -> Void)
}
