import SwiftUI

struct CategoryList: View {
    
    @StateObject var categoryVM = CategoryViewModel()
    
    @State var selectedCategory: String = ""
    @State var isActive: Bool = false
    @State var isFavoriteViewActive: Bool = false
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    NavigationLink(destination: ProductView(category: $selectedCategory), isActive: $isActive) {
                        EmptyView()
                    }
                    .hidden()
                    
                    if let categories = categoryVM.categories {
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
                // TODO: add cached images
                //
                
                .toolbar {
              
                    ToolbarItemGroup(placement: .principal) {
                        Text("Categories")
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        HStack {
                            NavigationLink(destination: SearchView()) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 24))
                            }
                            
                            
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
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden()
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
