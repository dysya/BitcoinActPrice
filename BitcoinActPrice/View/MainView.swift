//
//  ContentView.swift
//  BitcoinActPrice
//
//  Created by dan4 on 25.03.2022.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.colorScheme) private var systemColorScheme
    @State private var myColorScheme: ColorScheme?
    
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                        
                Text("Time to update: \(viewModel.data?.time.updated ?? "")")
                        
                Text("Actual rate: \(viewModel.data?.bpi.usd.rate ?? "") \(viewModel.data?.bpi.usd.code ?? "")")
                
                Spacer()
                        
                LineView(data: viewModel.chart, title: "Price chart")
            }
            .padding()
            .onAppear(perform: viewModel.updateData)
            .navigationBarItems(leading: Text("Bitcoin price").font(.title2).bold(), trailing: NavigationLink("⚙", destination: SettingsView(colorScheme: $myColorScheme)))
            .navigationBarTitleDisplayMode(.inline)
        }
        .colorScheme(myColorScheme ?? systemColorScheme)
        .onReceive(timer) { _ in
            viewModel.updateData()
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
