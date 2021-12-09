//
//  PhotoPickerModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 23.08.2021.
//

import SwiftUI
import Photos

struct PhotoPickerModel {
    enum MediaType {
        case photo, video, livePhoto
    }
    
    var id: String
    var photo: UIImage?
    var url: URL?
    var livePhoto: PHLivePhoto?
    var mediaType: MediaType = .photo
    
    init(with photo: UIImage) {
        id = UUID().uuidString
        self.photo = photo
        mediaType = .photo
    }
    
    init(with videoURL: URL) {
        id = UUID().uuidString
        url = videoURL
        mediaType = .video
    }
    
    init(with livePhoto: PHLivePhoto) {
        id = UUID().uuidString
        self.livePhoto = livePhoto
        mediaType = .livePhoto
    }
    
    mutating func delete() {
        switch mediaType {
        case .photo: photo = nil
        case .livePhoto: livePhoto = nil
        case .video:
            guard let url = url else { return }
            try? FileManager.default.removeItem(at: url)
            self.url = nil
        }
    }
}


class PickedMediaItems: ObservableObject {
    @Published var items = [PhotoPickerModel]()
    
    func append(item: PhotoPickerModel) {
        items.append(item)
        print("appended")
    }
    
    func store(timestamp: Date) -> String {
      //  print("in store function")
        var media_path = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmmssSSSSEdMMMy"
        let key = formatter.string(from: timestamp)
        
        for index in 0..<self.items.count {
            if let pngRepresentation = self.items[index].photo?.pngData() {
                if let filePath = self.filePath(forKey: "\(key)\(index)") {
                    
                    media_path += "\(key)\(index).png"
                    media_path += " "
                    print(media_path)
                    DispatchQueue.global(qos: .background).async {
                        do  {
                            try pngRepresentation.write(to: filePath,
                                                        options: .atomic)
                           
                        } catch let err {
                            print("Saving file resulted in error: ", err)
                        }
                    }
                }
            } else if let videoURL = self.items[index].url {
                media_path += "\(videoURL.lastPathComponent) "
                print(media_path)
            }
        }
       // print("media_path: \(media_path)")
        return media_path
    }
    
    // URL(string: String)
   // URL.absoluteString
    
    func retrieveImage(forKey key: String) -> UIImage? {
        if let filePath = URL(string: key),
           let fileData = FileManager.default.contents(atPath: filePath.path),
           let image = UIImage(data: fileData) {
            return image
        }
            
            return nil
    }
    
    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    func delete(item: PhotoPickerModel) {
        var ind: Int? = nil
        for index in 0..<items.count {
            if items[index].id == item.id {
                ind = index
            }
        }
        if ind != nil {
            items.remove(at: ind!)
        }
        
    }
    
    func deleteAll() {
        for (index, _) in items.enumerated() {
            items[index].delete()
        }
        
        items.removeAll()
    }
}
