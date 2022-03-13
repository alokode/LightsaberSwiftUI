//
//  ColorSelectorView.swift
//  Lightsaber
//
//  Created by Alok Sagar on 13/03/22.
//

import SwiftUI

struct ColorSelectorView: View {
    @Binding var saborColor:Color
    var body: some View {
        HStack(alignment:.center){
            ForEach ((0...6) , id: \.self){ index in
                Circle().fill(Color.getVibgyor(at: index)).frame(width: 45, height: 45).onTapGesture {
                    saborColor = .getVibgyor(at: index)
                }
            }
        }.offset( y: 10)
    }
}

struct ColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
       // ColorSelectorView(saborColor: )
    }
}
