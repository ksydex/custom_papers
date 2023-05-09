//
//  ContentView.swift
//  CustomPapers
//
//  Created by Артем Лукьянов on 25.02.2023.
//

import SwiftUI
struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1 - Play
            PlayView()
                .tabItem {
                    Image(systemName: "play.fill")
                }
                .tag(0)
            
            // Tab 2 - Configure
            ConfigureView()
                .tabItem {
                    Text("Configure")
                }
                .tag(1)
            
            // Tab 3 - About
            AboutView()
                .tabItem {
                    Text("About")
                }
                .tag(2)
        }
    }
}

struct PlayView: View {
    @State var isMixOn = false
    
    private let PlayButtonPadding = 50.0;
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                print("Play tapped")
            }) {
                Spacer()
                Text("Play")
                Spacer()
            }.font(.title)
            Toggle("Mix", isOn: $isMixOn)
                .font(.headline)
        
            Spacer()
        }
        .frame(maxWidth: 600)
    }
}

struct ConfigureView: View {
    var body: some View {
        NavigationView {
            ImageCrudView()
        }
    }
}

struct AboutView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Thank you for using")
                Text("CustomPapers")
                    .font(.system(size: 72, weight: .bold))
                    .padding(EdgeInsets(top: 0.5, leading: 0, bottom: 0.1, trailing: 0))
                Text("Version: 1.0.0")
                    .font(.headline)
                Text("By Artyom Lukyanov")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text("artglz63@gmail.com")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

