import SwiftUI

struct ContentView: View {
    @State private var alertIsVisible = false
    @State private var sliderValue = 50.0
    @State private var game = Game()
    @State private var showLeaderboard = false
    
    var body: some View {
        ZStack {
            Color.white
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
                    .padding(.horizontal, 20)
                
                Spacer()
                
                //Boton try
                Button("Try") {
                    alertIsVisible = true
                }
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 120, height: 120)
                .background(
                    Color(red: 0.95, green: 0.4, blue: 0.35)
                )
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
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
                    .padding(.bottom, 30)
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showLeaderboard) {
            LeaderboardView(leaderboardEntries: game.leaderboardEntries)
        }
    }
}

struct TargetView: View {
    let target: Int
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Tres dianas usando SF Symbols
            HStack(spacing: 20) {
                ForEach(0..<3) { _ in
                    ZStack {
                        
                        // Diana usando el símbolo target de SF Symbols
                        Image(systemName: "target")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.2))
                        
                        // Flecha/Dardo usando location.north.fill
                        Image(systemName: "location.north.fill")
                            .resizable()
                            .frame(width: 12, height: 16)
                            .foregroundColor(Color(red: 0.3, green: 0.75, blue: 0.85))
                            .rotationEffect(.degrees(45))
                            .offset(x: 18, y: -18)
                    }
                }
            }
            
            // Número objetivo
            Text("\(target)")
                .font(.system(size: 90, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

struct SliderView: View {
    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text("1")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            Slider(value: $value, in: 1...100)
                .accentColor(Color(red: 0.95, green: 0.4, blue: 0.35))
            
            Text("100")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
        }
        .padding(.horizontal)
    }
}

struct HeaderView: View {
    @Binding var showLeaderboard: Bool
    let onRestart: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onRestart) {
                Image(systemName: "arrow.counterclockwise")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
            
            Spacer()
            
            Button(action: { showLeaderboard = true }) {
                Image(systemName: "list.bullet")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
        }
    }
}

struct ScoreRoundView: View {
    let score: Int
    let round: Int
    
    var body: some View {
        HStack(spacing: 50) {
            VStack(spacing: 8) {
                Text("SCORE")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 3)
                    .frame(width: 120, height: 80)
                    .overlay(
                        Text("\(score)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                    )
            }
            
            VStack(spacing: 8) {
                Text("ROUND")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 3)
                    .frame(width: 120, height: 80)
                    .overlay(
                        Text("\(round)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                    )
            }
        }
    }
}

#Preview {
    ContentView()
}
