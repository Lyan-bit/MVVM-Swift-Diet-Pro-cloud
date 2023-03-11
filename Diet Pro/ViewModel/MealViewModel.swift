//
//  MealViewModel.swift
//  Diet Pro
//
//  Created by Lyan Alwakeel on 26/09/2022.
//

import Foundation

/* This code requires OclFile.swift */

func initialiseOclFile()
{
  //let systemIn = createByPKOclFile(key: "System.in")
  //let systemOut = createByPKOclFile(key: "System.out")
  //let systemErr = createByPKOclFile(key: "System.err")
}

/* This metatype code requires OclType.swift */

func initialiseOclType()
{ let intOclType = createByPKOclType(key: "int")
  intOclType.actualMetatype = Int.self
  let doubleOclType = createByPKOclType(key: "double")
  doubleOclType.actualMetatype = Double.self
  let longOclType = createByPKOclType(key: "long")
  longOclType.actualMetatype = Int64.self
  let stringOclType = createByPKOclType(key: "String")
  stringOclType.actualMetatype = String.self
  let sequenceOclType = createByPKOclType(key: "Sequence")
  sequenceOclType.actualMetatype = type(of: [])
  let anyset : Set<AnyHashable> = Set<AnyHashable>()
  let setOclType = createByPKOclType(key: "Set")
  setOclType.actualMetatype = type(of: anyset)
  let mapOclType = createByPKOclType(key: "Map")
  mapOclType.actualMetatype = type(of: [:])
  let voidOclType = createByPKOclType(key: "void")
  voidOclType.actualMetatype = Void.self
    
  let mealOclType = createByPKOclType(key: "Meal")
  mealOclType.actualMetatype = Meal.self

  let mealMealId = createOclAttribute()
        mealMealId.name = "mealId"
        mealMealId.type = stringOclType
        mealOclType.attributes.append(mealMealId)
  let mealMealName = createOclAttribute()
        mealMealName.name = "mealName"
        mealMealName.type = stringOclType
        mealOclType.attributes.append(mealMealName)
  let mealCalories = createOclAttribute()
        mealCalories.name = "calories"
        mealCalories.type = doubleOclType
        mealOclType.attributes.append(mealCalories)
  let mealDates = createOclAttribute()
        mealDates.name = "dates"
        mealDates.type = stringOclType
        mealOclType.attributes.append(mealDates)
  let mealImages = createOclAttribute()
        mealImages.name = "images"
        mealImages.type = stringOclType
        mealOclType.attributes.append(mealImages)
  let mealAnalysis = createOclAttribute()
        mealAnalysis.name = "analysis"
        mealAnalysis.type = stringOclType
        mealOclType.attributes.append(mealAnalysis)
  let mealUserName = createOclAttribute()
        mealUserName.name = "userName"
        mealUserName.type = stringOclType
        mealOclType.attributes.append(mealUserName)
  let userOclType = createByPKOclType(key: "User")
  userOclType.actualMetatype = User.self

  let userUserName = createOclAttribute()
        userUserName.name = "userName"
        userUserName.type = stringOclType
        userOclType.attributes.append(userUserName)
  let userGender = createOclAttribute()
        userGender.name = "gender"
        userGender.type = stringOclType
        userOclType.attributes.append(userGender)
  let userHeights = createOclAttribute()
        userHeights.name = "heights"
        userHeights.type = doubleOclType
        userOclType.attributes.append(userHeights)
  let userWeights = createOclAttribute()
        userWeights.name = "weights"
        userWeights.type = doubleOclType
        userOclType.attributes.append(userWeights)
  let userActivityLevel = createOclAttribute()
        userActivityLevel.name = "activityLevel"
        userActivityLevel.type = stringOclType
        userOclType.attributes.append(userActivityLevel)
  let userAge = createOclAttribute()
        userAge.name = "age"
        userAge.type = doubleOclType
        userOclType.attributes.append(userAge)
  let userTargetCalories = createOclAttribute()
        userTargetCalories.name = "targetCalories"
        userTargetCalories.type = doubleOclType
        userOclType.attributes.append(userTargetCalories)
  let userTotalConsumedCalories = createOclAttribute()
        userTotalConsumedCalories.name = "totalConsumedCalories"
        userTotalConsumedCalories.type = doubleOclType
        userOclType.attributes.append(userTotalConsumedCalories)
  let userBmr = createOclAttribute()
        userBmr.name = "bmr"
        userBmr.type = doubleOclType
        userOclType.attributes.append(userBmr)
}

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
    { let jdata = json.data(using: .utf8)!
      let decoder = JSONDecoder()
      if typeName == "String"
      { let x = try? decoder.decode(String.self, from: jdata)
          return x as AnyObject
      }
  return nil
    }


class MealViewModel: ObservableObject {
    static var instance : MealViewModel? = nil
    @Published var currentMeal : MealVO? = MealVO.defaultMealVO()
    @Published var currentMeals : [MealVO] = [MealVO]()
    
    static func getInstance() -> MealViewModel {
        if instance == nil
         { instance = MealViewModel()}
        return instance! }
    
    // Calculates the total calories consumed today
    var consumedClaories: Double {
        var caloriesToday : Double = 0
        for meal in currentMeals {
            caloriesToday += meal.calories
        }
        return caloriesToday
    }
            

    let dbpath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
    var fileSystem : FileAccessor = FileAccessor()
    var cdb : FirebaseDB = FirebaseDB.getInstance()
    
    //CRUD
    func createMeal(x : MealVO) {
        if let obj = getMealByPK(val: x.mealId)
        { cdb.persistMeal(x: obj) }
        else {
        let item : Meal = createByPKMeal(key: x.mealId)
          item.mealId = x.getMealId()
          item.mealName = x.getMealName()
          item.calories = x.getCalories()
          item.dates = x.getDates()
          item.images = x.getImages()
          item.analysis = x.getAnalysis()
          item.userName = x.getUserName()
        cdb.persistMeal(x: item)
        }
        currentMeal = x
}
        
func cancelCreateMeal() {
    //cancel function
}

func deleteMeal(id : String) {
    if let obj = getMealByPK(val: id)
    { cdb.deleteMeal(x: obj) }
}
    
func cancelDeleteMeal() {
    //cancel function
}

func cancelEditMeal() {
    //cancel function
}

    func cancelSearchMealByDate() {
//cancel function
}
    func listMeal() -> [MealVO] {
        currentMeals = [MealVO]()
        let list : [Meal] = mealAllInstances
        for (_,x) in list.enumerated()
        { currentMeals.append(MealVO(x: x)) }
        return currentMeals
    }
            
    func loadMeal() {
        let res : [MealVO] = listMeal()
        
        for (_,x) in res.enumerated() {
            let obj = createByPKMeal(key: x.mealId)
            obj.mealId = x.getMealId()
        obj.mealName = x.getMealName()
        obj.calories = x.getCalories()
        obj.dates = x.getDates()
        obj.images = x.getImages()
        obj.analysis = x.getAnalysis()
        obj.userName = x.getUserName()
            }
         currentMeal = res.first
         currentMeals = res
    }
        
    func stringListMeal() -> [String] {
        var res : [String] = [String]()
        for (_,obj) in currentMeals.enumerated()
        { res.append(obj.toString()) }
        return res
    }
            
    func searchByMealmealId(val : String) -> [MealVO] {
        var resultList: [MealVO] = [MealVO]()
        let list : [Meal] = mealAllInstances
        for (_,x) in list.enumerated() {
            if (x.mealId == val) {
                resultList.append(MealVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByMealmealName(val : String) -> [MealVO] {
        var resultList: [MealVO] = [MealVO]()
        let list : [Meal] = mealAllInstances
        for (_,x) in list.enumerated() {
            if (x.mealName == val) {
                resultList.append(MealVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByMealcalories(val : Double) -> [MealVO] {
        var resultList: [MealVO] = [MealVO]()
        let list : [Meal] = mealAllInstances
        for (_,x) in list.enumerated() {
            if (x.calories == val) {
                resultList.append(MealVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByMealdates(val : String) -> [MealVO] {
        var resultList: [MealVO] = [MealVO]()
        let list : [Meal] = mealAllInstances
        for (_,x) in list.enumerated() {
            if (x.dates == val) {
                resultList.append(MealVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByMealimages(val : String) -> [MealVO] {
        var resultList: [MealVO] = [MealVO]()
        let list : [Meal] = mealAllInstances
        for (_,x) in list.enumerated() {
            if (x.images == val) {
                resultList.append(MealVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByMealanalysis(val : String) -> [MealVO] {
        var resultList: [MealVO] = [MealVO]()
        let list : [Meal] = mealAllInstances
        for (_,x) in list.enumerated() {
            if (x.analysis == val) {
                resultList.append(MealVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByMealuserName(val : String) -> [MealVO] {
        var resultList: [MealVO] = [MealVO]()
        let list : [Meal] = mealAllInstances
        for (_,x) in list.enumerated() {
            if (x.userName == val) {
                resultList.append(MealVO(x: x))
            }
        }
      return resultList
    }
    
        
    func getMealByPK(val: String) -> Meal?
        { return Meal.mealIndex[val] }
            
    func retrieveMeal(val: String) -> Meal?
            { return Meal.mealIndex[val] }
            
    func allMealids() -> [String] {
            var res : [String] = [String]()
            for (_,item) in currentMeals.enumerated()
            { res.append(item.mealId + "") }
            return res
    }
            
    func setSelectedMeal(x : MealVO)
        { currentMeal = x }
            
    func setSelectedMeal(i : Int) {
        if i < currentMeals.count
        { currentMeal = currentMeals[i] }
    }
            
    func getSelectedMeal() -> MealVO?
        { return currentMeal }
            
    func persistMeal(x : Meal) {
        let vo : MealVO = MealVO(x: x)
        cdb.persistMeal(x: x)
        currentMeal = vo
    }
        
    func editMeal(x : MealVO) {
        if let obj = getMealByPK(val: x.mealId) {
         obj.mealId = x.getMealId()
         obj.mealName = x.getMealName()
         obj.calories = x.getCalories()
         obj.dates = x.getDates()
         obj.images = x.getImages()
         obj.analysis = x.getAnalysis()
         obj.userName = x.getUserName()
        cdb.persistMeal(x: obj)
        }
        currentMeal = x
    }
    
    func addUsereatsMeal(x: String, y: String) {
          if let obj = getMealByPK(val: y) {
          obj.userName = x
          cdb.persistMeal(x: obj)
          }
      }
      
      func cancelAddUsereatsMeal() {
          //cancel function
      }
      
    func removeUsereatsMeal(x: String, y: String) {
          if let obj = getMealByPK(val: y) {
          obj.userName = "NULL"
          cdb.persistMeal(x: obj)
          }
      }
          
      func cancelRemoveUsereatsMeal() {
          //cancel function
      }
        
        
}
