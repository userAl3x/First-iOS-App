//
//  ContentView.swift
//  First iOS App
//
//  Created by Alex Jiménez Quiñonero on 19/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var alertIsVisible = false
    @State private var sliderValue = 50.0
    @State private var game = Game()
    @State private var showLeaderboard = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HeaderView(
                    showLeaderboard: $showLeaderboard,
                    onRestart: {
                        game.restart()
                        sliderValue = 50.0
                    }
                )
                
                Spacer()
                
                TargetView(target: game.target)
                
                Spacer()
                
                SliderView(value: $sliderValue)
                
                Button("Try".uppercased()) {
                    alertIsVisible = true
                }
                .padding(20.0)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("AccentColor"), Color("AccentColor").opacity(0.8)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(21.0)
                .font(.title3)
                .fontWeight(.bold)
                .alert(isPresented: $alertIsVisible) {
                    let roundedValue = Int(sliderValue.rounded())
                    let points = game.points(sliderValue: roundedValue)
                    
                    return Alert(
                        title: Text("Your Score"),
                        message: Text("\(points) Points\n" +
                                    "Target: \(game.target)\n" +
                                    "Your guess: \(roundedValue)"),
                        dismissButton: .default(Text("Next Round")) {
                            game.startNewRound(points: points)
                            sliderValue = 50.0
                        }
                    )
                }
                
                Spacer()
                
                ScoreRoundView(score: game.score, round: game.round)
            }
            .padding()
        }
        .sheet(isPresented: $showLeaderboard) {
            LeaderboardView(leaderboardEntries: game.leaderboardEntries)
        }
    }
}

struct TargetView: View {
    let target: Int
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                ForEach(0..<3) { _ in
                    Image(systemName: "target")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("AccentColor"))
                }
            }
            
            Text("\(target)")
                .font(.system(size: 72, weight: .black))
                .kerning(-1.0)
                .foregroundColor(.primary)
        }
    }
}

struct SliderView: View {
    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text("1")
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            Slider(value: $value, in: 1...100)
                .accentColor(Color("AccentColor"))
            
            Text("100")
                .fontWeight(.bold)
                .foregroundColor(.secondary)
        }
    }
}

struct HeaderView: View {
    @Binding var showLeaderboard: Bool
    let onRestart: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onRestart) {
                Image(systemName: "arrow.clockwise")
                    .font(.title)
                    .foregroundColor(.primary)
                    .frame(width: 56, height: 56)
                    .overlay(Circle().stroke(Color.primary, lineWidth: 2))
            }
            
            Spacer()
            
            Button(action: { showLeaderboard = true }) {
                Image(systemName: "list.dash")
                    .font(.title)
                    .foregroundColor(.primary)
                    .frame(width: 56, height: 56)
                    .overlay(Circle().stroke(Color.primary, lineWidth: 2))
            }
        }
    }
}

struct ScoreRoundView: View {
    let score: Int
    let round: Int
    
    var body: some View {
        HStack(spacing: 40) {
            VStack {
                Text("SCORE")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary, lineWidth: 2)
                    .frame(width: 100, height: 60)
                    .overlay(
                        Text("\(score)")
                            .font(.title2)
                            .fontWeight(.bold)
                    )
            }
            
            VStack {
                Text("ROUND")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary, lineWidth: 2)
                    .frame(width: 100, height: 60)
                    .overlay(
                        Text("\(round)")
                            .font(.title2)
                            .fontWeight(.bold)
                    )
            }
        }
    }
}

#Preview {
    ContentView()
}
