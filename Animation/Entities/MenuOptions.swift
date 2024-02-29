//
//  MenuOptions.swift
//  Animation
//
//  Created by Daniil MacBook Pro on 29.02.2024.
//

import Foundation

enum MenuOptions: String, CaseIterable {
    case home = "Home"
    case greed = "Greed"
    case loader = "Loader"
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .greed:
            return "greetingcard"
        case .loader:
            return "arrow.3.trianglepath"
        }
    }
}
