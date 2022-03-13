//
//  SaberLaser.swift
//  Lightsaber
//
//  Created by Alok Sagar on 13/03/22.
//

import SwiftUI

struct SaberLaser: View {
    @Binding var saberHeight:CGFloat
    @Binding var saberWidth:CGFloat
    @Binding var saberOpacity:CGFloat
    @Binding var saborColor:Color
    var offSetY:CGFloat
    
    
    var body: some View {
        ZStack {
            Capsule().fill(saborColor).frame(width: saberWidth ,height: saberHeight).blur(radius: 0).opacity(saberOpacity)
            Capsule().fill(saborColor).frame(width: saberWidth ,height: saberHeight).blur(radius: 4).opacity(saberOpacity)
            Capsule().fill(saborColor).frame(width: saberWidth ,height: saberHeight).blur(radius: 10).opacity(saberOpacity)
            Capsule().fill(saborColor).frame(width: 20 ,height: saberHeight).blur(radius: 20).opacity(saberOpacity)
        }.offset( y: offSetY)

    }
}

struct SaberLaser_Previews: PreviewProvider {
    static var previews: some View {
      Text("")
    }
}
