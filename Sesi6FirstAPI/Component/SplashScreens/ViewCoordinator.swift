//
//  ViewCoordinator.swift
//  Sesi6FirstAPI
//
//  Created by Hidayat Abisena on 28/01/24.
//

import SwiftUI

struct ViewCoordinator: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            Group {
                if isActive {
                    CardView()
                    Spacer()
                    
                } else {
                    SplashScreen(isActive: $isActive)
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    ViewCoordinator()
}
