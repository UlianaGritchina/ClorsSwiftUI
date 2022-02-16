//
//  ContentView.swift
//  ClorsSwiftUI
//
//  Created by Ульяна Гритчина on 15.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var red: Double = 1
    @State private var green: Double = 1
    @State private var blue: Double = 1
    @State private var redTextValue = ""
    @State private var greenTextValue = ""
    @State private var blueTextValue = ""
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: red, green: green, blue: blue).ignoresSafeArea()
                
                ColorBoard(
                    valuesForSliders: [$red, $green, $blue],
                    textValues: [$redTextValue,
                                 $greenTextValue,
                                 $blueTextValue]
                )
            }
            .navigationTitle("Colors")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.endEditing()
                        if !redTextValue.isEmpty {
                            red = (Double(redTextValue) ?? 255) / 255
                        }
                        if !greenTextValue.isEmpty {
                            green = (Double(greenTextValue) ?? 255) / 255
                        }
                        if !blueTextValue.isEmpty {
                        blue = (Double(blueTextValue) ?? 255) / 255
                        }
                    }
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSlider: View {
    let color: Color
    @Binding var value: Double
    @Binding var textValue: String
    
    var body: some View {
        HStack {
            Text("\(lround(value * 255))").frame(width: 35, height: 10)
            Slider(value: $value).tint(color)
            TextField("0...255", text: $textValue)
                .textFieldStyle(.roundedBorder)
                .frame(width: 70, height: 10)
                .keyboardType(.numberPad)
        }.padding()
    }
}

struct ColorBoard: View {
    var valuesForSliders: [Binding <Double>]
    var textValues: [Binding <String>]
    var mainWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: mainWidth - 20 , height: 200)
                .foregroundColor(.white)
                .blur(radius: 1)
                .shadow(color: Color.black.opacity(0.5),
                        radius: 10,
                        x: 10,
                        y: 10)
            VStack {
                ColorSlider(color: .red,
                            value: valuesForSliders[0],
                            textValue: textValues[0])
                
                ColorSlider(color: .green,
                            value: valuesForSliders[1],
                            textValue: textValues[1])
                
                ColorSlider(color: .blue,
                            value: valuesForSliders[2],
                            textValue: textValues[2])
            }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
