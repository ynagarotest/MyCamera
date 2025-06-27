//
//  EffectView.swift
//  MyCamera
//
//  Created by Yasuo Nagaro on 2025/06/27.
//

import SwiftUI

struct EffectView: View {
    
    @Binding var isShowSheet: Bool
    let captureImage: UIImage
    @State var showImage: UIImage?
    
    var body: some View {
        VStack {
            Spacer()
            
            if let showImage {
                Image(uiImage: showImage)
                    .resizable()
                    .scaledToFit()
                
            }
            
            Button {
                
            } label: {
                Text("閉じる")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
            }
            .padding()
        }
        .onAppear() {
            showImage = captureImage
        }
    
    }
}

#Preview {
    EffectView()
}
