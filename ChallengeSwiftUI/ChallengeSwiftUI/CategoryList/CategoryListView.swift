import SwiftUI

struct CategoryList: View {
    
    @StateObject var  categoryVM = CategoryViewModel()
    
    @State var selectedCategory: String = ""
    @State var isActive: Bool = false
    @State var isFavoriteViewActive: Bool = false
    
    
    var body: some View {
        VStack {
            NavigationLink(destination: ProductView(category: $selectedCategory), isActive: $isActive) {
                EmptyView()
            }
            .hidden()
            
            if let categories = categoryVM.categories {
                HStack {
                    Text("Categories")
                        .font(.custom("Pacifico-Regular", size: 30))
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                    
                    Spacer()
                    
                    NavigationLink(destination: FavoriteView(), isActive: $isFavoriteViewActive) {
                        ZStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.yellow)
                            
                            Text("\(categoryVM.getDefaultArrayLength())")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(.blue)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        }
                    }
                    
                    
                }
                .padding()
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(categories, id: \.self) { category in
                            
                            AuthButton(buttonText: category) {
                                selectedCategory = category
                                isActive = true
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                do {
                    await categoryVM.getProductsFromServices()
                }
            }
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
