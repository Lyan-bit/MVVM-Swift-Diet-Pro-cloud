	                  
import Foundation
import SwiftUI

class UserViewModel : ObservableObject {
		                      
	static var instance : UserViewModel? = nil
		
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> UserViewModel {
		if instance == nil
	     { instance = UserViewModel()}
	    return instance! }
	                          
	init() {
		currentUser = getUser()
		loadUser()
	}

	@Published private var preference = ModelPreferencesManager()
	@Published var currentUser : UserVO? = UserVO.defaultUserVO()
	@Published var currentUsers : [UserVO] = [UserVO]()


    func createUser(x : UserVO) {
        let res : User = createByPKUser(key: x.userName)
        res.userName = x.userName
        res.gender = x.gender
        res.heights = x.heights
        res.weights = x.weights
        res.activityLevel = x.activityLevel
        res.age = x.age
        res.targetCalories = x.targetCalories
        res.totalConsumedCalories = x.totalConsumedCalories
        res.bmr = x.bmr

        currentUser = x
	    currentUsers = [UserVO] ()
	    currentUsers.append(x)
	    
        preference.user = x
    }
    
    func getUser () -> UserVO? {
    	currentUser = preference.user
    	if (currentUser != nil) {
	    currentUsers = [UserVO] ()
	    currentUsers.append(currentUser!)
	    }
        return currentUser
    }
    
	func cancelCreateUser() {
		//cancel function
	}
	
		func findTotalConsumedCaloriesByDate (x: FindTotalConsumedCaloriesByDateVO, dates: String) -> Double {
	      var result = 0.0

var totalConsumedCalories: Double
  totalConsumedCalories  = 0.0
for (_,meal) in x.getMeals() {
	if meal.userName == x.getUser().userName && meal.dates == dates {
		    totalConsumedCalories  = totalConsumedCalories + meal.calories
	}
}
  x.getUser().totalConsumedCalories  = totalConsumedCalories
persistUser (x: x.getUser())
  result  = totalConsumedCalories
	if x.isFindTotalConsumedCaloriesByDateError()
	   {   return result }
        x.setResult(x: result )
	   
	return result
        
    }
       
	func cancelFindTotalConsumedCaloriesByDate() {
		//cancel function
	}
	          
		func findTargetCalories (x: FindTargetCaloriesVO) -> Double {
	      var result = 0.0

  x.getUser().targetCalories  = x.getUser().calculateTargetCalories()
persistUser (x: x.getUser())
  result  = x.getUser().targetCalories
	if x.isFindTargetCaloriesError()
	   {   return result }
        x.setResult(x: result )
	   
	return result
        
    }
       
	func cancelFindTargetCalories() {
		//cancel function
	}
	          
		func findBMR (x: FindBMRVO) -> Double {
	      var result = 0.0

  x.getUser().bmr  = x.getUser().calculateBMR()
persistUser (x: x.getUser())
  result  = x.getUser().bmr
	if x.isFindBMRError()
	   {   return result }
        x.setResult(x: result )
	   
	return result
        
    }
       
	func cancelFindBMR() {
		//cancel function
	}
	          
		func caloriesProgress (x: CaloriesProgressVO) -> Double {
	      var result = 0.0

var progress: Double
  progress  = (x.getUser().totalConsumedCalories / x.getUser().targetCalories) * 100
persistUser (x: x.getUser())
  result  = progress
	if x.isCaloriesProgressError()
	   {   return result }
        x.setResult(x: result )
	   
	return result
        
    }
       
	func cancelCaloriesProgress() {
		//cancel function
	}
		  
	func loadUser() {
			let res : [UserVO] = listUser()
			
			for (_,x) in res.enumerated() {
				let obj = createByPKUser(key: x.userName)
		        obj.userName = x.getUserName()
        obj.gender = x.getGender()
        obj.heights = x.getHeights()
        obj.weights = x.getWeights()
        obj.activityLevel = x.getActivityLevel()
        obj.age = x.getAge()
        obj.targetCalories = x.getTargetCalories()
        obj.totalConsumedCalories = x.getTotalConsumedCalories()
        obj.bmr = x.getBmr()
				}
			 currentUser = res.first
			 currentUsers = res
		}
		
		func listUser() -> [UserVO] {
			currentUser = getUser()
	            if currentUser != nil {
	                currentUsers = [UserVO]()
	                currentUsers.append(currentUser!)
	            }
            return currentUsers
		}
						
	func stringListUser() -> [String] { 
		currentUsers = listUser()
		var res : [String] = [String]()
		for (_,obj) in currentUsers.enumerated()
		{ res.append(obj.toString()) }
		return res
	}
			
	func getUserByPK(val: String) -> User? {
		var res : User? = User.getByPKUser(index: val)
		if res == nil {
		   res = createByPKUser(key: preference.user.userName)
		}
		return res 
	}
			
	func retrieveUser(val: String) -> User? {
		let res : User? = getUserByPK(val: val)
		return res 
	}
			
	func allUserids() -> [String] {
		var res : [String] = [String]()
		for (_,item) in currentUsers.enumerated()
		{ res.append(item.userName + "") }
		return res
	}
			
	func setSelectedUser(x : UserVO)
		{ currentUser = x }
			
	func setSelectedUser(i : Int) {
		if 0 <= i && i < currentUsers.count
		{ currentUser = currentUsers[i] }
	}
			
	func getSelectedUser() -> UserVO?
		{ return currentUser }
			
	func persistUser(x : User) {
		let vo : UserVO = UserVO(x: x)
		editUser(x: vo)
	}
		
	func editUser(x : UserVO) {
		let val : String = x.userName
		let res : User? = User.getByPKUser(index: val)
		if res != nil {
		res!.userName = x.userName
		res!.gender = x.gender
		res!.heights = x.heights
		res!.weights = x.weights
		res!.activityLevel = x.activityLevel
		res!.age = x.age
		res!.targetCalories = x.targetCalories
		res!.totalConsumedCalories = x.totalConsumedCalories
		res!.bmr = x.bmr
		}
		currentUser = x
		preference.user = x
	 }
		
    func cancelUserEdit() {
    	//cancel function
    }
    
 	func searchByUseruserName(val : String) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.userName == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUsergender(val : String) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.gender == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUserheights(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.heights == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUserweights(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.weights == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUseractivityLevel(val : String) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.activityLevel == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUserage(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.age == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUsertargetCalories(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.targetCalories == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUsertotalConsumedCalories(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.totalConsumedCalories == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUserbmr(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.bmr == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		

	}
