//
//  Meal.swift
//  Diet Pro
//
//  Created by Lyan Alwakeel on 11/03/2023.
//


import Foundation

class Meal  {
    
  private static var instance : Meal? = nil
  
  init() {
      //init
  }
  
  init(copyFrom: Meal) {
      self.mealId = "copy" + copyFrom.mealId
      self.mealName = copyFrom.mealName
      self.calories = copyFrom.calories
      self.dates = copyFrom.dates
      self.images = copyFrom.images
      self.analysis = copyFrom.analysis
      self.userName = copyFrom.userName
      self.eatenBy = copyFrom.eatenBy
  }
  
  func copy() -> Meal
  { let res : Meal = Meal(copyFrom: self)
      addMeal(instance: res)
      return res
  }
  
static func defaultInstanceMeal() -> Meal
    { if (instance == nil)
    { instance = createMeal() }
    return instance!
}

deinit
{ killMeal(obj: self) }


  var mealId: String = ""  /* primary key */
  var mealName: String = ""
  var calories: Double = 0.0
  var dates: String = ""
  var images: String = ""
  var analysis: String = ""
  var userName: String = ""
    var eatenBy : User = User.defaultInstanceUser()

  static var mealIndex : Dictionary<String,Meal> = [String:Meal]()

  static func getByPKMeal(index : String) -> Meal?
  { return mealIndex[index] }


}

  var mealAllInstances : [Meal] = [Meal]()

  func createMeal() -> Meal
    { let result : Meal = Meal()
        mealAllInstances.append(result)
      return result }
  
  func addMeal(instance : Meal)
    { mealAllInstances.append(instance) }

  func killMeal(obj: Meal)
    { mealAllInstances = mealAllInstances.filter{ $0 !== obj } }

  func createByPKMeal(key : String) -> Meal
    { var result : Meal? = Meal.getByPKMeal(index: key)
      if result != nil {
          return result!
      }
      result = Meal()
        mealAllInstances.append(result!)
      Meal.mealIndex[key] = result!
      result!.mealId = key
      return result! }

  func killMeal(key : String)
    { Meal.mealIndex[key] = nil
        mealAllInstances.removeAll(where: { $0.mealId == key })
    }
    
    extension Meal : Hashable, Identifiable
    {
      static func == (lhs: Meal, rhs: Meal) -> Bool
      {       lhs.mealId == rhs.mealId &&
      lhs.mealName == rhs.mealName &&
      lhs.calories == rhs.calories &&
      lhs.dates == rhs.dates &&
      lhs.images == rhs.images &&
      lhs.analysis == rhs.analysis &&
      lhs.userName == rhs.userName
      }
    
      func hash(into hasher: inout Hasher) {
        hasher.combine(mealId)
        hasher.combine(mealName)
        hasher.combine(calories)
        hasher.combine(dates)
        hasher.combine(images)
        hasher.combine(analysis)
        hasher.combine(userName)
      }
    }
    

