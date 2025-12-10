//
//  ContentView.swift
//  SalikProject
//
//  Created by raghad alenezi on 16/06/1447 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomePageView()
                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
