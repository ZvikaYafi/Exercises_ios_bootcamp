import SwiftUI

struct CategoryList: View {
    @StateObject var categoryVM = CategoryViewModel()
    @State var selectedCategory: String = ""
    @State var isActive: Bool = false
    @State var isFavoriteViewActive: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    NavigationLink(destination: ProductView(category: $selectedCategory), isActive: $isActive) {
                        EmptyView()
                    }
                    .hidden()
                    
                    // List of category
                    if let categories = categoryVM.categories {
                        categotyList(categories: categories)
                    } else {
                        ProgressView()
                    }
                }
                
                // Toolbar at the top of the screen
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
                                FavoriteIcon(count: categoryVM.getDefaultArrayLength())
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        
        // Loading the category list
        .onAppear {
            Task {
                do {
                    try await categoryVM.getCategoryFromServices()
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
        }
        
        // If there is an error returns an alert
        .alert(isPresented: Binding<Bool>.constant(!errorMessage.isEmpty)) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK"), action: {
                self.errorMessage = ""
            }))
        }
    }
    
    @ViewBuilder
    func FavoriteIcon(count: Int) -> some View {
        ZStack {
            Image(systemName: "star.fill")
                .font(.system(size: 24))
                .foregroundColor(.yellow)
            Text("\(count)")
                .font(.caption)
                .foregroundColor(.white)
                .padding(4)
                .background(.blue)
                .clipShape(Circle())
                .offset(x: 10, y: -10)
        }
    }
    
    // view of list
    @ViewBuilder
    func categotyList(categories: [String]) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(categories, id: \.self) { category in
                    AuthButton(buttonText: category) {
                        selectedCategory = category
                        isActive = true
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}

// An extension in the String class that will each have an ID
extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
