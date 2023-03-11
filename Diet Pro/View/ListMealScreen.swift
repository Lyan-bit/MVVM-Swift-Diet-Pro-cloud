
import SwiftUI

struct ListMealView: View {
    @ObservedObject var model : MealViewModel = MealViewModel.getInstance()

     var body: some View
     { List(model.currentMeals){ instance in 
     	ListMealRowScreen(instance: instance) }
       .onAppear(perform: { model.listMeal() })
     }
    
}

struct ListMealView_Previews: PreviewProvider {
    static var previews: some View {
        ListMealView(model: MealViewModel.getInstance())
    }
}

