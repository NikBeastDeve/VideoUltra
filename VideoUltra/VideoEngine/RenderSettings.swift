//
//  RenderSettings.swift
//  VideoUltra
//
//  Created by Nikita Galaganov on 19/03/2023.
//

import AVFoundation
import UIKit
import Photos

struct RenderSettings {
    
    var size : CGSize = .zero
    var fps: Int32 = 6
    var avCodecKey = AVVideoCodecType.h264
    var videoFilename = "render"
    var videoFilenameExt = "mp4"
    var musicTrackPath = ""
    var audioUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "aac")!)
    
    
    var outputURL: URL {
        // Use the CachesDirectory so the rendered video file sticks around as long as we need it to.
        // Using the CachesDirectory ensures the file won't be included in a backup of the app.
        let fileManager = FileManager.default
        if let tmpDirURL = try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            return tmpDirURL.appendingPathComponent(videoFilename).appendingPathExtension(videoFilenameExt)
        }
        fatalError("URLForDirectory() failed")
    }
}
