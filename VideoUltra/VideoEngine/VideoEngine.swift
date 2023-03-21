//
//  VideoEngine.swift
//  VideoUltra
//
//  Created by Nikita Galaganov on 20/03/2023.
//

import Foundation
import UIKit

final class VideoEngine {
    
    private let semanticImage = SemanticsSegmentation()
    
    var images: [UIImage]
    let musicPath: URL
    var imagesForVideo: [UIImage] = []
    
    init(images: [UIImage] = [],
         pathToMusic: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "aac")!),
         shoudlUseDefaultImages: Bool = true) {
        self.images = images
        self.musicPath = pathToMusic
        
        if shoudlUseDefaultImages {
            for i in 1...8 {
                self.images.append(UIImage(named: "example_\(i)")!)
            }
        }
    }
    
    func makeClip(completion: (()->Void)?) {
        generateImagesForClip()
        generateVideoClip() {
            completion?()
        }
    }
    
    private func generateImagesForClip() {
        for image in images {
            // first we add original image
            imagesForVideo.append(image)
            
            // get next image from list
            guard let nextImage = images.next(item: image) else {
                return
            }
            
            // get people from first image
            // get background of next image
            // then put people from first picture to background of previous picture
            guard let followingFrameImage = semanticImage.saliencyBlend(objectUIImage: nextImage, backgroundUIImage: image) else {
                return
            }
            imagesForVideo.append(followingFrameImage)
        }
        
        // next we make video from all images we have
        
        // then put audio track to generated video
        
    }
    
    private func generateVideoClip(completion: (()->Void)?) {
        var settings = RenderSettings()
        settings.videoFilename = UUID().uuidString
        settings.size = UIScreen.main.bounds.size
        settings.audioUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "aac")!)
        
        let imageAnimator = ImageAnimator(renderSettings: settings)
        imageAnimator.images = imagesForVideo
        imageAnimator.render() {
            completion?()
        }
    }
    
}
