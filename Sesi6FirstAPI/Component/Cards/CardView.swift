//
//  ContentView.swift
//  Sesi6FirstAPI
//
//  Created by Hidayat Abisena on 28/01/24.
//

import SwiftUI

struct CardView: View {
    @State private var fadeIn: Bool = false
    @State private var moveDownward: Bool = false
    @State private var moveUpward: Bool = false
    
    var type = ["general","knock-knock","programming","anime","food","dad", ]
    @State private var selectedType = "general"

    
    @StateObject private var jokeVM = JokeVM()

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack {
                        Text("Setup:")
                            .foregroundStyle(.white)
                            .font(.custom("PermanentMarker-Regular", size: 30))
                        
                        Text(jokeVM.joke?.setup ?? Constant.DefaultValues.noJokes)
                            .foregroundStyle(.white)
                            .fontWeight(.light)
                            .italic()
                            .padding(.horizontal)
                    }
                    .offset(y: moveDownward ? -218 : -300)
                    
                    Text(jokeVM.joke?.punchline ?? Constant.DefaultValues.noJokes)
                        .foregroundStyle(.white)
                        .font(.custom("PermanentMarker-Regular", size: 35))
                        .multilineTextAlignment(.center)
                    
                    Button {
                        playSingleSound(sound: "sound-chime", type: "mp3")
                        Task {
                            await jokeVM.fetchNextJoke(jokeType: selectedType)
                        }
                    } label: {
                        HStack {
                            Text("Punchline".uppercased())
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            
                            Image(systemName: "arrow.right.circle")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 24)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.color07, Color.color08]), startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(Capsule())
                        .shadow(color: Color("ColorShadow"), radius: 6, x: 0, y: 3)
                    }
                    .offset(y: moveUpward ? 210 : 300)
                    
                    .task {
                        await jokeVM.fetchJoke(jokeType: selectedType)
                    }
                }
                .frame(width: 335, height: 545)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.color07, Color.color08]), startPoint: .top, endPoint: .bottom)
                )
                .opacity(fadeIn ? 1.0 : 0.0)
                .onAppear() {
                    withAnimation(.linear(duration: 1.2)) {
                        self.fadeIn.toggle()
                    }
                    
                    withAnimation(.linear(duration: 0.6)) {
                        self.moveDownward.toggle()
                        self.moveUpward.toggle()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                Spacer()
                Picker("Please choose a type", selection: $selectedType) {
                    ForEach(type, id: \.self) {
                        Text($0)
                    }
                }
                
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        await jokeVM.fetchJoke(jokeType: selectedType)
                    }
                }) {
                    Image(systemName: "goforward")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
        CardView()
}
