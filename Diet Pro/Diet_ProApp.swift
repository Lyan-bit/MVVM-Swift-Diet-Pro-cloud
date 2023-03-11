//
//  Diet_ProApp.swift
//  Diet Pro
//
//  Created by Lyan Alwakeel on 26/09/2022.
//

import SwiftUI
import Firebase

@main
struct Diet_ProApp: App {
    init() {
        FirebaseApp.configure()
           }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
