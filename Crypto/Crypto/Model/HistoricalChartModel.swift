//
//  HistoricalChartModel.swift
//  Crypto
//
//  Created by tiago on 16/02/2026.
//

import Foundation

struct HistoricalChartModel: Codable {
    let price: [[Double]]
    let marketCaps: [[Double]]
    let totalVolumes: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case price
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

struct HistoricalChartModelMock: Decodable {
    static let chartData = HistoricalChartModel (
        price: [
            [
                1711843200000,
                69702.3087473573
            ],
            [
                1711929600000,
                71246.9514406015
            ],
            [
                1711983682000,
                68887.7495158568
            ]
        ],
        marketCaps: [
            [
                1711843200000,
                1370247487960.09
            ],
            [
                1711929600000,
                1401370211582.37
            ],
            [
                1711983682000,
                1355701979725.16
            ]
        ],
        totalVolumes: [
            [
                1711843200000,
                16408802301.8374
            ],
            [
                1711929600000,
                19723005998.215
            ],
            [
                1711983682000,
                30137418199.6431
            ]
        ]
    )
    
}
