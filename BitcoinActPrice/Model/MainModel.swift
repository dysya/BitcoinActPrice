//
//  MainModel.swift
//  BitcoinActPrice
//
//  Created by dan4 on 25.03.2022.
//

import Foundation

struct QuoteData: Decodable {
    let time: Time
    let disclaimer, chartName: String
    let bpi: Bpi
}

struct Time: Decodable {
    let updated: String
    let updatedISO: String
    let updateduk: String
}

struct Bpi: Decodable {
    let usd, gbp, eur: Currency
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct Currency: Decodable {
    let code, symbol, rate, eurDescription: String
    let rateFloat: Double
    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case eurDescription = "description"
        case rateFloat = "rate_float"
    }
}
