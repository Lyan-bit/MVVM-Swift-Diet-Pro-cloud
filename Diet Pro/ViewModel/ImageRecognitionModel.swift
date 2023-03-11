	                  
import Foundation
import SwiftUI

class ImageRecognitionModel : ObservableObject {
    
    var meal: MealViewModel = MealViewModel()
		                      
	static var instance : ImageRecognitionModel? = nil
	private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
	
	static func getInstance() -> ImageRecognitionModel {
		if instance == nil
	     { instance = ImageRecognitionModel() }
	    return instance! }
	                          
    func imageRecognition(x : String) -> String {
        guard let obj = meal.getMealByPK(val: x)
        else {
            return "Please selsect valid mealId"
        }
        
		let dataDecoded = Data(base64Encoded: obj.images, options: .ignoreUnknownCharacters)
		let decodedimage:UIImage = UIImage(data: dataDecoded! as Data)!
        		
    	guard let pixelBuffer = decodedimage.pixelBuffer() else {
        	return "Error"
    	}
    
        // Hands over the pixel buffer to ModelDatahandler to perform inference
        let inferencesResults = modelParser?.runModel(onFrame: pixelBuffer)
        
        // Formats inferences and resturns the results
        guard let firstInference = inferencesResults else {
          return "Error"
        }
        
        obj.analysis = firstInference[0].label
        meal.persistMeal(x: obj)
        
        return firstInference[0].label
        
    }
    
	func cancelImageRecognition() {
		//cancel function
	}
	    
}
