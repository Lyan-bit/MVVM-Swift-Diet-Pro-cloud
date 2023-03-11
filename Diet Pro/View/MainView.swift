//
//  MainView.swift
//  Diet Pro
//
//  Created by Lyan Alwakeel on 26/09/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject private var model = MealViewModel()
    @StateObject private var user = UserViewModel()
    @StateObject private var recognition = ImageRecognitionModel()
    
    var body: some View {
        TabView {
            CreateMealView(model: model)
                .tabItem{
                    Label("Create", systemImage: "square.and.pencil")
                }
            
            ListMealView(model: model)
                .tabItem{
                    Label("Meals List", systemImage: "list.bullet.rectangle.portrait")
                }
            
            EditMealView(model: model)
                .tabItem{
                    Label("Edit Meal", systemImage: "slider.horizontal.3")
                }
            
            DeleteMealView(model: model)
                .tabItem{
                    Label("Delete", systemImage: "delete.left")
                }
            
            SearchMealByDatedatesScreen (model: model).tabItem {
            Image(systemName: "5.square.fill")
            Text("SearchMealByDatedates")}
            
            CreateProfileUserScreen (model: user).tabItem {
                        Image(systemName: "6.square.fill")
                        Text("+ProfileUser")}
            
            ListUserScreen (model: user).tabItem {
                        Image(systemName: "7.square.fill")
                        Text("ListUser")}

            FindTotalConsumedCaloriesByDateScreen (model: model, user: user).tabItem {
                        Image(systemName: "8.square.fill")
                        Text("FindTotalConsumedCaloriesByDate")}
            FindTargetCaloriesScreen (model: user).tabItem {
                        Image(systemName: "9.square.fill")
                        Text("FindTargetCalories")}
            FindBMRScreen (model: user).tabItem {
                        Image(systemName: "10.square.fill")
                        Text("FindBMR")}
//            CaloriesProgressScreen(model: user).tabItem {
//                        Image(systemName: "11.square.fill")
//                        Text("CaloriesProgress")}
//            AddUsereatsMealScreen (model: model, user: user).tabItem {
//                        Image(systemName: "12.square.fill")
//                        Text("AddUsereatsMeal")}
//            RemoveUsereatsMealScreen (model: model, user: user).tabItem {
//                        Image(systemName: "13.square.fill")
//                        Text("RemoveUsereatsMeal")}
//            ImageRecognitionScreen (model: recognition, meal: model).tabItem {
//                        Image(systemName: "14.square.fill")
//                        Text("ImageRecognition")}
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
