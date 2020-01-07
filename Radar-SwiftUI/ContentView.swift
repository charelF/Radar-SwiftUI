//
//  ContentView.swift
//  Radar-SwiftUI
//
//  Created by Charel FELTEN on 06/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
// 

import SwiftUI
import Combine
import MapKit


enum NetworkError: Error {
    case noData
}


class DataBase: ObservableObject {
    @Published var activities: [Activity] = []
    
    func getActivities() {
        guard let url = URL(string: "http://127.0.0.1:8081/activities") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard data != nil else { throw NetworkError.noData }
                let activities = try JSONDecoder().decode([Activity].self, from: data!)
                DispatchQueue.main.async {
                    print(activities)
                    self.activities = activities
                }
            } catch {
                print("JSONDecoder error: \(error)")
            }
        }.resume()
    }
    
    init() {
        getActivities()
    }
}


struct ContentView: View {
    
    @ObservedObject var data = DataBase()
    
    var body: some View {
        return TabView {
            
            ActivityMapView(coordinates: data.activities.map({ $0.coordinate }))
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
            }.tag(1)
            
            ActivityListView(data: data)
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
            }.tag(2)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() //activities: testData)
    }
}
