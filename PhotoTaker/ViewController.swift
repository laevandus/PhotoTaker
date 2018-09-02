//
//  ViewController.swift
//  PhotoTaker
//
//  Created by Toomas Vahter on 02/09/2018.
//  Copyright © 2018 Augmented Code. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func takePhoto(_ sender: Any) {
        openPhotoPicker(withSource: .camera)
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        openPhotoPicker(withSource: .photoLibrary)
    }
    
    private func openPhotoPicker(withSource source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { fatalError() }
        let picker: UIImagePickerController = {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = source
            return picker
        }()
        present(picker, animated: true, completion:nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let handleImage: (UIImage?) -> () = { (image) in
            self.imageView.image = image
            self.imageView.isHidden = (image == nil)
            if let image = image {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
        if let image = info[.editedImage] as? UIImage {
            handleImage(image)
        }
        else if let image = info[.originalImage] as? UIImage {
            handleImage(image)
        }
        else {
            handleImage(nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
