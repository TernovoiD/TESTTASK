import UIKit

protocol ImageViewControllerDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}

class ImageViewController: UIViewController, UINavigationControllerDelegate {
    weak var delegate: ImageViewControllerDelegate?
    private let buttonColor = UIColor(named: "secondarySecondary")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let uploadButton = UIButton(type: .system)
        uploadButton.setTitle(LocalizedText.Button.upload, for: .normal)
        uploadButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        uploadButton.setTitleColor(buttonColor, for: .normal)
        uploadButton.backgroundColor = .clear
        
        uploadButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        uploadButton.addTarget(self, action: #selector(buttonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        uploadButton.layer.cornerRadius = 24
        uploadButton.clipsToBounds = true
        
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uploadButton)
        
        NSLayoutConstraint.activate([
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uploadButton.widthAnchor.constraint(equalToConstant: 91),
            uploadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func showOptions() {
        let actionSheet = UIAlertController(title: LocalizedText.choosePhoto, message: nil, preferredStyle: .actionSheet)
        actionSheet.overrideUserInterfaceStyle = .light
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: LocalizedText.camera, style: .default, handler: { _ in
                self.presentImagePicker(sourceType: .camera, useFrontCamera: true)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: LocalizedText.gallery, style: .default, handler: { _ in
            self.presentImagePicker(sourceType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: LocalizedText.Button.cancel, style: .cancel, handler: nil))

        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        if let color = UIColor(named: "customSecondary") {
            sender.backgroundColor = color.withAlphaComponent(0.1)
        }
    }

    @objc private func buttonReleased(_ sender: UIButton) {
        sender.backgroundColor = .clear
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType, useFrontCamera: Bool = false) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        if sourceType == .camera && useFrontCamera { imagePicker.cameraDevice = .front }
        present(imagePicker, animated: true, completion: nil)
    }
}


// MARK: - Delegate
extension ImageViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: {
            if let image = info[.originalImage] as? UIImage {
                self.delegate?.didSelectImage(image)
            }
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
