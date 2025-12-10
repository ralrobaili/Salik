//
//  AppState.swift
//  SalikProject
//
//  Created by raghad alenezi on 18/06/1447 AH.
//
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var selectedTab: Int = 0     // ← هذا أهم شيء
}

