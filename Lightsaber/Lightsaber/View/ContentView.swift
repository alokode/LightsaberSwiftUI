//
//  ContentView.swift
//  Lightsaber
//
//  Created by Alok Sagar on 13/03/22.
//

import SwiftUI
import AVFoundation

enum LightSaberState {
    case turningOn
    case active
    case turningOff
    case inActive
}

let starsCount = 300
struct ContentView: View {
    @State var saberHeight:CGFloat = 0
    @State var saberWidth:CGFloat = 45
    @State var saberOpacity:CGFloat = 1
    @State var saborColor:Color = .getVibgyor(at: 0)
    @State var saberState:LightSaberState = .inActive
    @State var startBlinking:Bool = false

    var screenWidth:CGFloat   {UIScreen.main.bounds.width}
    var screenHeight:CGFloat  { UIScreen.main.bounds.height}
    var startPositionsX = (1...starsCount).map( {_ in CGFloat.random(in: 1...UIScreen.main.bounds.width)} )
    var startPositionsY = (1...starsCount).map( {_ in CGFloat.random(in: 1...UIScreen.main.bounds.height)} )
    
    var body: some View {
        ZStack {
            //This is to show stars with blink animation. Need to add a proper solution
            ForEach ((0..<starsCount) , id: \.self){ index in
                Circle().fill(.white).frame(width: CGFloat.random(in: (0...7)), height: CGFloat.random(in: (0...6)), alignment: .center).position(x: startPositionsX[index], y: startPositionsY[index]).opacity( startBlinking ? 1 : 0).animation(.easeInOut(duration: 1).delay(Double(index) * 0.1).repeatForever(autoreverses: true), value: startBlinking)
            }
            VStack(alignment:.center) {
                //Saber laser
                SaberLaser(saberHeight: $saberHeight, saberWidth: $saberWidth, saberOpacity: $saberOpacity, saborColor: $saborColor, offSetY: 23)
                ZStack { //Saber hadnle
                    Image("saber").resizable().frame(width: 250, height: 250, alignment: .bottom).offset(x: 9).onTapGesture {
                       updateSaberState()
                    }
                    let gradient = LinearGradient.init(gradient: .init(colors: [.black,saborColor,saborColor,.black]), startPoint: .leading, endPoint: .trailing)
                  
                    Capsule().fill(gradient).frame(width: 20, height: 45, alignment: .center)
                        .offset(x: 0, y: 35)
                        .blur(radius:0.5)
                }
                ColorSelectorView(saborColor: $saborColor) //Saber color selector
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .bottom
              ).background(.clear)
        }.background(.black).onAppear {
            startBlinking.toggle()
        }
    }
    // updateSaberHeight
    private func updateSaberHeight(){
        if saberState == .turningOn || saberState == .active {
            saberHeight = 0
        } else {
            saberHeight = screenHeight * 0.70
        }
    }
    
    //Update state
    private func updateSaberState(){
        withAnimation(.easeInOut(duration: 0.8)) {
            updateSaberHeight()
            if saberState == .turningOn || saberState == .active{
                saberState = .turningOff
            } else {
                saberState = .turningOn
            }
            DispatchQueue.main.async {
              SoundManager.shared.playSound(state: saberState)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

