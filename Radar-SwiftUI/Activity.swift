//
//  Activity.swift
//  Radar-SwiftUI
//
//  Created by Charel FELTEN on 08/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation
import MapKit

class ActivityWrapper: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let activity: Activity
    let title: String?
    let subtitle: String?
    
    init(activity: Activity) {
        self.activity = activity
        self.title = activity.name
        self.coordinate = activity.coordinate
        self.subtitle = activity.desc
    }
}

struct Activity: Identifiable  {
    
    let name: String
    let desc: String
    
    let subcategory: Subcategory
    
    // some strange things happen with lazy vars and mutability in SwiftUI...
    // here it is explained: https://stackoverflow.com/questions/57316270/cannot-use-mutating-getter-on-immutable-value-self-is-immutable-error
    // but I dont understand the explanantion nor how to fix it
    // for now easiest workaround is to use computed properties instead of lazy vars
    
//    lazy var category: Category = subcategory.category
    var category: Category { subcategory.category }

//    lazy var emoji: String = subcategory.emoji
    var emoji: String { subcategory.emoji }
    
    let coordinate: CLLocationCoordinate2D
    
    let creationTime: Date = Date()
    let activityTime: Date
    
    let id: UUID = UUID()
    
    var comments: [Comment] = []
}


struct Comment {
    let user: String // not final, however workaround until User is defined
    let content: String
    let id: UUID = UUID()
}


enum Category: String {
    case sport = "Sport"
    case game = "Game"
}


enum Subcategory: String {
    case soccer = "Soccer"
    case basketball = "Basketball"
    case tennis = "Tennis"
    
    case videogame = "Videogame"
    case boardgame = "Boardgame"
    
    var category: Category {
        switch self {
        case .soccer, .basketball, .tennis:
            return .sport
        case .videogame, .boardgame:
            return .game
        }
    }
    
    var emoji: String {
        switch self {
        case .soccer: return "⚽️"
        case .basketball: return "🏀"
        case .tennis: return "🥎"
        
        case .videogame: return "🎮"
        case .boardgame: return "🎲"
        }
    }
}



let testData: [Activity] = [
    Activity(name: "dungeons and dragons",
             desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description",
             subcategory: .boardgame,
             coordinate: CLLocationCoordinate2D(latitude: 49.631622, longitude: 6.171935),
             activityTime: Date()
    ),
    
    Activity(name: "Fussbal match",
             desc: "fussbal match zu cruchten",
             subcategory: .soccer,
             coordinate: CLLocationCoordinate2D(latitude: 49.621622, longitude: 6.161935),
             activityTime: Date()
    )
]
