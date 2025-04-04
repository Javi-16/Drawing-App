//
//  ContentView.swift
//  Drawing App
//
//  Created by english on 2025-04-04.
//

import SwiftUI

struct ContentView: View {
    // Array of paths
    @State private var paths: [Path] = []
    @State private var currentPath = Path()
    
    var body: some View {
        VStack {
            Text("My Drawing App")
                .font(.title)
                .fontWeight(.bold)
            
            CanvasView(paths: $paths, currentPath: $currentPath)
                .background(.white)
                .overlay {
                    Rectangle().stroke(.blue, lineWidth: 1)
                }.gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({value in
                            if currentPath.isEmpty {
                                currentPath.move(to: value.location)
                            }
                            currentPath.addLine(to: value.location)
                        })
                        .onEnded({ _ in
                            paths.append(currentPath)
                            currentPath = Path()
                        })
                )
            
            HStack() {
                Button {
                    if !paths.isEmpty {
                        paths.removeLast()
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.black)
                }
                
                Spacer()
                
                Button {
                    if !paths.isEmpty {
                        paths.removeAll()
                    }
                } label: {
                    Image(systemName: "clear.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.red)
                }
            }
            .padding()
        }
        .padding()
    }
}

struct CanvasView: View {
    @Binding var paths: [Path]
    @Binding var currentPath: Path
    
    var body: some View {
        ZStack() {
            ForEach(0..<paths.count, id: \.self) {
                index in
                paths[index]
                    .stroke(.black, lineWidth: 2)
            }
            currentPath.stroke(.black, lineWidth: 2)
        }
    }
}

#Preview {
    ContentView()
}
