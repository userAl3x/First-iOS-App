//
//  Game.swift
//  First iOS App
//
//  Created by Alex Jiménez Quiñonero on 23/11/25.
//

import Foundation

//Logica del juego
struct Game {
    var target: Int = Int.random(in: 1...100)
    var score: Int = 0
    var round: Int = 1
    var leaderboardEntries: [LeaderboardEntry] = []
    
    func points(sliderValue: Int) -> Int {
        let difference = abs(target - sliderValue)
        let points: Int
        
        if difference == 0 {
            points = 200
        } else if difference <= 5 {
            points = 150
        } else if difference <= 10 {
            points = 100
        } else {
            points = max(100 - difference, 0)
        }
        
        return points
    }
    
    mutating func startNewRound(points: Int) {
        addToLeaderboard(score: points)
        score += points
        round += 1
        target = Int.random(in: 1...100)
    }
    
    mutating func restart() {
        score = 0
        round = 1
        target = Int.random(in: 1...100)
        leaderboardEntries = []
    }
    
    mutating func addToLeaderboard(score: Int) {
        let entry = LeaderboardEntry(
            round: round,
            score: score,
            date: Date()
        )
        leaderboardEntries.append(entry)
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let round: Int
    let score: Int
    let date: Date
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
