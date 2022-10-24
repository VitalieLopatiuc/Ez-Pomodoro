//
//  ContentView.swift
//  Ez Pomodoro
//
//  Created by Vitalie Lopatiuc on 9/15/22.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250

    var body: some View {
        
        
        ZStack{
            Color.orange
                .opacity(0.10)
                .edgesIgnoringSafeArea(.all)

            VStack{
                Text("\(vm.time)")
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                    .foregroundColor(vm.minutes > 10 ? Color.green : vm.minutes > 3 ? Color.yellow : Color.red)
                    .padding()
                    .frame(width: width)
                    .background(.thinMaterial)
                    .cornerRadius(25)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray, lineWidth: 4))
                    .alert("Take a break!", isPresented: $vm.showingAlert) {
                        Button("Continue", role: .cancel) {
                            vm.start(minutes: 2)
                            vm.flagBreak = true
                            vm.showingAlert = false
                        }
                    }
                    .alert("Go back to work!", isPresented: $vm.anotherAlert) {
                        Button("Continue", role: .cancel) {
                            vm.start(minutes: vm.cycleTime)
                            vm.flagBreak = false
                            vm.anotherAlert = false
                            vm.counter += 1
                        }
                    }
                    .alert("Good work!", isPresented: $vm.finalAlert) {
                        Button("Ok", role: .cancel) {
                            vm.reset()
                        }
                    }
                
                HStack {
                    Image("tomato_0")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .opacity(vm.counter > 1 ? 1.0 : 0.1)
//                        .foregroundColor(vm.minutes > 10 ? Color.green : vm.minutes > 3 ? Color.purple : Color.red)
                    
                    Image("tomato_1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .opacity(vm.counter > 2 ? 1.0 : 0.1)

//                        .foregroundColor(vm.minutes > 10 ? Color.blue : vm.minutes > 3 ? Color.purple : Color.red)
                    
                    Image("tomato_2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .opacity(vm.counter > 3 ? 1.0 : 0.1)

                    
                    Image("tomato_3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .opacity(vm.counter > 4 ? 1.0 : 0.1)
                    
                }
                
                
                Slider(value: $vm.minutes, in: 1...30, step: 1)
                    .padding()
                    .disabled(vm.isActive)
                    .animation(.easeInOut, value: vm.minutes)
                    .frame(width: width)

                HStack(spacing: 50) {
                    Button("START") {
                        vm.start(minutes: vm.minutes)
                        vm.counter += 1
                    }
                    .padding()
                    .tint(.white)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .disabled(vm.isActive)
                    
                    Button("RESET", action: vm.reset)
                        .tint(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
            }
            .onReceive(timer) { _ in
                vm.updateCountdown()
            }

        }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
