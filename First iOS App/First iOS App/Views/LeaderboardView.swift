//
//  LeaderboardView.swift
//  First iOS App
//
//  Created by Alex Jiménez Quiñonero on 23/11/25.
//

import SwiftUI

struct LeaderboardView: View {
    @Environment(\.dismiss) var dismiss
    let leaderboardEntries: [LeaderboardEntry]
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Text("MARKS")
                        .font(.title)
                        .fontWeight(.bold)
                        .tracking(3)
                    
                    Spacer()
                    
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.95, green: 0.4, blue: 0.35))
                    .font(.body)
                    .fontWeight(.bold)
                }
                .padding()
                
                if leaderboardEntries.isEmpty {
                    Spacer()
                    Text("No hay partidas jugadas todavíaz")
                        .foregroundColor(.secondary)
                        .font(.title3)
                    Spacer()
                } else {
                    List {
                        ForEach(leaderboardEntries) { entry in
                            HStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.primary, lineWidth: 2)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Text("\(entry.round)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                    )
                                
                                Text("\(entry.score)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading) //cambiar .leading por center
                                
                                Text(entry.formattedDate)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                }
            }
        }
    }
}

#Preview {
    LeaderboardView(leaderboardEntries: [
        LeaderboardEntry(round: 1, score: 81, date: Date()),
        LeaderboardEntry(round: 2, score: 78, date: Date()),
        LeaderboardEntry(round: 3, score: 70, date: Date())
    ])
}
