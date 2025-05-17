import SwiftUI

struct ImageLoader: View {
    @Binding var image: UIImage?
    
    var body: some View {
        HStack {
            Text(LocalizedText.uploadPhoto)
                .foregroundStyle(.black.opacity(0.48))
                .font(.nunito(size: 16))
            Spacer()
            ImageSelector(for: $image)
                .setWidth(100)
        }
        .setHeight(56)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .overlay { lineOverlay }
    }
}

#Preview {
    ImageLoader(image: .constant(nil))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.customBackground)
}

private extension ImageLoader {
    var lineOverlay: some View {
        RoundedRectangle(cornerRadius:4, style: .continuous)
            .stroke(.customGray, lineWidth: 1)
    }
}

private struct ImageSelector: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    init(for image: Binding<UIImage?>) {
        self._selectedImage = image
    }
    
    func makeUIViewController(context: Context) -> ImageViewController {
        let viewController = ImageViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: ImageViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ImageViewControllerDelegate {
        var parent: ImageSelector
        
        init(_ parent: ImageSelector) {
            self.parent = parent
        }
        
        func didSelectImage(_ image: UIImage) {
            parent.selectedImage = image
        }
    }
}
