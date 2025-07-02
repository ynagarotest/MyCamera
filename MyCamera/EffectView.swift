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
    let filterArray = ["CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectChrome","CIPhotoEffectFade", "CIPhotoEffectTonal"]
    
    @State var filterSelectNumber: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            if let showImage {
                Image(uiImage: showImage)
                    .resizable()
                    .scaledToFit()
                
            }
            
            Button {
                let filterName = filterArray[filterSelectNumber]
                
                filterSelectNumber += 1
                
                if filterSelectNumber == filterArray.count {
                    filterSelectNumber = 0
                }
                
                let rotate = captureImage.imageOrientation
                let inputImage = CIImage(image: captureImage)
                guard let effectFilter = CIFilter(name: filterName) else { return }
                
                effectFilter.setDefaults()
                effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
                guard let outputImage = effectFilter.outputImage else { return }
                
                let ciContect = CIContext(options: nil)
                guard let cgImage = ciContect.createCGImage(outputImage, from: outputImage.extent) else { return }
                
                showImage = UIImage(
                    cgImage: cgImage,
                    scale: 1.0,
                    orientation: rotate
                )
                
            } label: {
                Text("エフェクト")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                
            }
            .padding()
            
            if let showImage = showImage?.resized() {
                let shareImage = Image(uiImage: showImage)
                ShareLink(item: shareImage, subject: nil, message: nil, preview: SharePreview("Photo", image: shareImage)){
                    Text("シェア")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .multilineTextAlignment(.center)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                }
                .padding()
            }
            
            Button {
                isShowSheet.toggle()
                
            } label: {
                Text("閉じる")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
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
    EffectView(
        isShowSheet: .constant(true),
        captureImage: UIImage(named: "preview_use")!
    )
}
