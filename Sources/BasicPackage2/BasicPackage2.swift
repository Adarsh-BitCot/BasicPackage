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

public func callAPI(urlString: String, httpMethod: HTTPRequest.HTTPMethod, params: [String:Any] = [:], body: [String:Any]? = .none) {
    let client: HTTPClient = NetworkClient()
    guard let url = URL(string: urlString) else { return }
    
    let request = HTTPRequest(
        url: url,
        httpMethod: httpMethod,
        params: params,
        body: body,
        customHeaders: headers
    )
    
    client.request(request, type: BaseModel<User>.self) { result in
        switch result {
        case .success(let response):
            completion(.success(response))
        case .failure(let error):
            completion(.failure(NetworkError.network(error)))
        }
    }
}

//@available(iOS 13.0.0, *)
//public func callAPI(url: String) -> some View{
////    AF.request(url).response { response in
////        if let data = response.data{
////            do{
////                let decoded = try JSONDecoder().decode(model, from: data)
//////                self.dataSet.append((decoded.data?.first)!)
////            }catch{
////                print(error.localizedDescription)
////            }
////        }
////    }
//    return Text("API Called")
//}

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
