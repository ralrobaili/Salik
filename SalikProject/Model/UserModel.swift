//
//  UserModel.swift
//  SalikProject
//
//  Created by raghad alenezi on 16/06/1447 AH.
//
import SwiftUI
import Combine

final class UserModel: ObservableObject {
    @Published var name: String = ""
    @Published var phone: String = ""

    func logout() {
        name = ""
        phone = ""
    }
}
