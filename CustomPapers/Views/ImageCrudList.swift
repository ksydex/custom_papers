//
//  ImageCrudList.swift
//  CustomPapers
//
//  Created by Артем Лукьянов on 25.02.2023.
//

import SwiftUI
import URLImage

struct ImageCrudView: View {
    @State private var images = [ImageModel]()
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                if images.isEmpty {
                    Text("No images yet. Tap '+' to add one.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List {
                        ForEach(images) { image in
                            ImageRowView(image: image)
                        }
                        .onMove(perform: move)
                        .onDelete(perform: delete)
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingAddSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 32))
                    }
                    .padding()
                    .sheet(isPresented: $showingAddSheet) {
                        AddImageView(images: self.$images)
                    }
                }
            }
            .navigationTitle("Images")
            .toolbar {
                Button(action: {}) {
                    Text("Edit")
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        images.remove(atOffsets: offsets)
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        images.move(fromOffsets: source, toOffset: destination)
    }
}

struct ImageRowView: View {
    let image: ImageModel
    
    var body: some View {
        HStack {
            image.preview
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            Text(image.url)
        }
    }
}

struct AddImageView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var images: [ImageModel]
    @State private var url = ""
    @State private var previewImage: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image URL")) {
                    TextField("URL", text: $url, onCommit: {})
                        .keyboardType(.URL)
                }
                
                Section(header: Text("Preview")) {
                    if !url.isEmpty {
                        URLImage(URL(string: "https://i.imgur.com/5yeBVeM.jpeg")!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    } else {
                        Text("Enter an image URL above to preview it.")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .navigationBarTitle(Text("Add Image")
//                                , displayMode: .automatic
            )
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let newImage = ImageModel(url: url, preview: Image(uiImage: previewImage ?? UIImage()))
                    self.images.append(newImage)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(previewImage == nil || url.isEmpty)
            )
        }
    }
}

struct ImageModel: Identifiable {
    let id = UUID()
    let url: String
    let preview: Image
}

struct ImageCrudView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCrudView()
    }
}
