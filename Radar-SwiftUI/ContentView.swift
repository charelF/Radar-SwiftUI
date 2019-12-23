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
        guard let url = URL(string: "http://127.0.0.1:8081/activity") else { return }
        
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
        let activities = data.activities
        return TabView {
            
            ActivityMapView(coordinates: activities.map({ $0.coordinate }))
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
            }.tag(1)
            
            ActivityListView(activities: activities)
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
            }.tag(2)
            
        }
    }
}


struct ActivityListView: View {
    var activities: [Activity]
    
    var body: some View {
        NavigationView {
            List(activities) { activity in
                ActivityCell(activity: activity)
            }
        .navigationBarTitle("Activities")
        }
        
    }
}


struct ActivityCell: View {
    var activity: Activity
    
    var body: some View {
        NavigationLink(destination: ActivityView(activity: activity)) {
            Text(activity.emoji)
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text(activity.name)
                
                Text(activity.desc)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() //activities: testData)
    }
}
