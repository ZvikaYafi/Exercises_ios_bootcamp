
import SwiftUI

struct CategoryList: View {
    
    @StateObject var productsVM = ProductViewModel()
    @State var selectedCategory:String = ""
    @State var isActive :Bool = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: ProductView(category: $selectedCategory,productsVM: productsVM), isActive: $isActive ) {
                EmptyView()
            }.hidden()
            Text("Category")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            if let categories = productsVM.categories {
                
                
                List(categories, id: \.self) { category in
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.selectedCategory = category
                            self.isActive = true
                        }
                }
                
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await productsVM.getProductsFromServices()
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
