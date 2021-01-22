//
//  MockAPIManger.swift
//  MuslimAssisstantAssessmentTests
//
//  Created by Abo-Aljoud94 on 1/21/21.
//

import Foundation
@testable import MuslimAssisstantAssessment

class MockAPIManger {
    var shouldReturnError = false
    var getCountriesWasCalled = false
    var getCountryDetailsWasCalled = false
    
    enum MockServiceError: Error {
        case getCountries
        case getCountryDetails
    }
    
    func reset(){
        shouldReturnError = false
        getCountriesWasCalled = false
        getCountryDetailsWasCalled = false
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let MockCountriesResponse = ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua-and-Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh"]
    
}

extension MockAPIManger: APIManagerProtocol {
    func getCountryDetails(countryName: String, completion: @escaping (Result<CountryStatistics, Error>) -> Void) {
        
    }
    
    func getCountries(completion: @escaping (Result<[String], Error>) -> Void) {
        getCountriesWasCalled = true
        
        if shouldReturnError {
            completion(.failure(MockServiceError.getCountries))
        } else {
            completion(.success(MockCountriesResponse))
        }
    }
    
    
}
