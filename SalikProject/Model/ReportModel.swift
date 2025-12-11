//
//  ReportModel.swift
//  SalikProject
//
//  Created by raghad alenezi on 19/06/1447 AH.
//


import Foundation

struct ReportModel: Identifiable {
    var id = UUID()
    var status: String
    var location: String
    var date: Date
    var severity: String
    var errorPercentage: Int
}
