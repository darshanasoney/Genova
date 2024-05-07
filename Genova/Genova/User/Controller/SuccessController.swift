//
//  SuccessController.swift
//  Genova
//
//  Created by home on 21/08/23.
//

import UIKit

class SuccessController: UIViewController {
    
    @IBOutlet weak var btnBack : UIButton!
    @IBOutlet weak var bgImage : UIImageView!
    
    var context = CIContext(options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    func setUp() {
        self.btnBack.layer.borderWidth = 3
        self.btnBack.layer.borderColor = UIColor.white.cgColor
        self.blurEffect()
    }
    
    @IBAction func backToHome(_ sender : UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func blurEffect() {

        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: bgImage.image!)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)

        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        bgImage.image = processedImage
    }
}
