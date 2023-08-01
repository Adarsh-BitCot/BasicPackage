import Alamofire
import SwiftUI
import UIKit
import Foundation
import Kingfisher
import SDWebImage

public struct BasicPackage2 {
    public private(set) var text = "Hello, World!"
    
    public init() {
    }
}

@available(iOS 13.0.0, *)
public func getAPICall<V>(url: String,
                          type: V.Type,
                          completion: @escaping (V?, Errors?) -> Void) where V : Decodable {
    
    NetworkManager.shared.makeAPICall(urlString: url) { result in
        switch result {
        case .success(let data):
            do {
                print(data.prettyString ?? "")
                let object = try JSONDecoder().decode(type, from: data)
                completion(object, nil)
            } catch _ {
                completion(nil, .invalidData)
            }
        case .failure(let error):
            completion(nil, error)
        }
    }
}

public func postAPICall<V>(url: String,
                        param: [String:Any],
                        headers: HTTPHeaders = [:],
                        type: V.Type,
                        completion: @escaping (V?, Errors?) -> Void) where V : Decodable {
   
    NetworkManager.shared.makeAPICall(urlString: url,
                                      parameters: param,
                                      headers: headers,
                                      method: "POST") { result in
        switch result {
        case .success(let data):
            do{
                print(data.prettyString ?? "")
                let object = try JSONDecoder().decode(type, from: data)
                completion(object, nil)
            } catch _ {
                completion (nil, .invalidData)
            }
        case .failure(let error):
            completion(nil, error)
        }
    }
}

public func openLink(url: String) {
    UIApplication.shared.open(URL(string: url)!)
}

public func uploadImage(image: UIImage, baseUrl: String, closer: @escaping (Bool) -> Void){
    var headers:HTTPHeaders{
        get{
            return ["Content-Type":"image/jpeg"]
        }
    }
    let imageData = image.jpegData(compressionQuality: 0.8)
    AF.upload(imageData!, to:  baseUrl, method: .put, headers: headers)
        .responseData {
            response in
            
            guard let httpResponse = response.response else {
                print("Something went wrong uploading")
                closer(false)
                return
            }
            if httpResponse.statusCode == 200{
                closer(true)
            }else{
                closer(true)
            }
        }
}

public func loadImage(imageView:UIImageView, photoURL:String, placeholder: UIImage? = UIImage(named: "icon_mailerAccount")){
    //here the king fisher pod is used to sample the image so that it does not again download the image from the server.
    let url = URL(string: photoURL)
    imageView.sd_imageIndicator = SDWebImageActivityIndicator.white
    if SDImageCache.shared.diskImageDataExists(withKey: photoURL){
        DispatchQueue.main.async {
            imageView.image = SDImageCache.shared.imageFromDiskCache(forKey: photoURL)
            imageView.sd_imageIndicator = nil
        }
    }else{
        SDWebImageDownloader.shared.downloadImage(with: url, options: .lowPriority) { receivedSize, expectedSize, url in
            print(CGFloat(receivedSize), CGFloat(expectedSize))
        } completed: { image, downloaddata, error, finished in
            imageView.sd_imageIndicator = nil
            DispatchQueue.main.async {
                if finished{
                    SDImageCache.shared.store(image, forKey: photoURL)
                    if image != nil {
                        imageView.image = image
                    }else{
                        imageView.image = placeholder
                    }
                }else{
                    imageView.image = placeholder
                }
            }
        }
    }
}

extension Data {
    var prettyString: NSString? {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) ?? nil
    }
}
