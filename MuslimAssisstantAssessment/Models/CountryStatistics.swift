//
//  CountryDetail.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/20/21.
//

import Foundation

struct Test: Codable {
    let total: Int
}

struct Death: Codable {
    let new: String?
    let total: Int
}

struct Case: Codable {
    let new : String?
    let active: Int?
    let critical: Int?
    let recovered: Int?
    let total: Int
}

struct Response: Codable {
    let continent: String
    let country: String
    let population: Int
    let day: String
    let cases: Case
    let deaths: Death
    let tests: Test
    let time: String
}

struct CountryStatistics: Codable {
    let response: [Response]
}
