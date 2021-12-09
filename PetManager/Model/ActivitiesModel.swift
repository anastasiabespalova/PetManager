//
//  ActivitiesModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 22.08.2021.
//

import Foundation
import SwiftUI

struct Activity: Hashable {
    var title: String
    var detailedView: Bool
    var offset: CGFloat
    
    var description: String
    
    var popupUndetailedTitle: String
    var popupDetailedTitle: String
    var popupUndetailedDescription: String
    var popupDetailedDescription: String
    var popupButton: String
    
    init(title: String) {
        switch title {
        case "cage":
            self.title = "cage"
            self.popupButton = "Cleaned up!"
            self.description = "Keep the cage or tray clean. You can set up a reminder in the settings"
            
            self.popupUndetailedTitle = "Cleaned up!"
        case "claws":
            self.title = "claws"
            self.popupButton = "Done"
            self.description = "Keep track of the length of the claws for your pet's comfort"
            
            self.popupUndetailedTitle = "Looks great!"
        case "food":
            self.title = "food"
            self.popupButton = "Bon Appetit!"
            self.description = "Monitor the quality and quantity of food. If your pet ate something strange, you can add a photo or video"
            
            self.popupUndetailedTitle = "Bon Appetit!"
        case "parasites":
            self.title = "parasites"
            self.popupButton = "Bye-bye parasites"
            self.description = "Treat your pet from external and internal parasites in time. Add a photo or name of the drug used"
            
            self.popupUndetailedTitle = "Bye-bye parasites!"
        case "pee":
            self.title = "pee"
            self.popupButton = "Done"
            self.description = "Track urinary frequency, especially if your pet is having problems. If urine contains impurities, add a photo to show to the vet"
            
            self.popupUndetailedTitle = "Pee"
        case "pills":
            self.title = "pills"
            self.popupButton = "Done"
            self.description = "If your pet needs to take medications, mark so as not to forget. You can customize the list of drugs taken in the settings"
            
            self.popupUndetailedTitle = "Pills"
        case "poo":
            self.title = "poo"
            self.popupButton = "Done"
            self.description = "Monitor the frequency and quality of the poop. If it differs from usual, you can take a photo or video to show to the veterinarian"
            
            self.popupUndetailedTitle = "Great!"
        case "training":
            self.title = "training"
            self.popupButton = "Good work!"
            self.description = "Exercise your pet's brain. You can rate your workout and add a description to track your progress"
            
            self.popupUndetailedTitle = "Good work!"
        case "vaccine":
            self.title = "vaccine"
            self.popupButton = "Done"
            self.description = "If your pet needs vaccinations, set yourself a reminder so you don't forget. Because it matters"
            
            self.popupUndetailedTitle = "Good work!"
        case "vomit":
            self.title = "vomit"
            self.popupButton = "Done"
            self.description = "Sometimes vomiting is normal. But it is better to write down all cases and take a photo to show to the veterinarian"
            
            self.popupUndetailedTitle = "Ugggh!"
        case "walk":
            self.title = "walk"
            self.popupButton = "Time to have a rest!"
            self.description = "Record all of your walks with your pet and watch your activity to ensure it gets the necessary physical activity"
            
            self.popupUndetailedTitle = "Time to have a rest!"
        case "washing":
            self.title = "washing"
            self.popupButton = "Done"
            self.description = ""
            
            self.popupUndetailedTitle = "Looks great!"
        case "water":
            self.title = "water"
            self.popupButton = "Done"
            self.description = "If your pet is unable to keep its coat and skin clean on its own, you can set a reminder for yourself"
            
            self.popupUndetailedTitle = "Mmm, clean water!"
        case "weight":
            self.title = "weight"
            self.popupButton = "Done"
            self.description = "It is very important to monitor the weight of the animal. Add weighting and track weight loss statistics"
            
            self.popupUndetailedTitle = "Weight"
        default:
            self.title = "claws"
            self.popupButton = "Done"
            self.description = "It is very important to monitor the weight of the animal. Add weighting and track weight loss statistics"
            
            self.popupUndetailedTitle = "Looks great!"
        }
        self.detailedView = false
        self.offset = 0
        
       
        self.popupDetailedTitle = ""
        self.popupUndetailedDescription = ""
        self.popupDetailedDescription = ""
        
    }
}

extension String {
    var mentionedActivities: [String] {
        let parts = split(separator: " ")

        // Character sets may be inverted to identify all
        // characters that are *not* a member of the set.
        let delimiterSet = CharacterSet.letters.inverted

        return parts.compactMap { part in
            // Here we grab the first sequence of letters right
            // after the @-sign, and check that it’s non-empty.
            let name = part.components(separatedBy: delimiterSet)[0]
            return name.isEmpty ? nil : name
        }
    }
    
  /*  var mentionedKeys: [String] {
        return split(self) {$0 == " "}
      /*  let parts = split(separator: " ")
        var result: [String] = []
        for part in parts {
            result.append(part)
        }*/
    }*/
}

/*
protocol Activity {
    var title: String { get }
    var detailedView: Bool {
        get set
    }
    var offset: CGFloat {
        get set
    }
    
    var description: String { get}
    
    var popupUndetailedTitle: String { get }
    var popupDetailedTitle: String { get }
    var popupUndetailedDescription: String { get }
    var popupDetailedDescription: String { get }
    var popupButton: String { get }
}


struct FoodActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Bon Appetit!"
    
    var description = ""
    
    var offset: CGFloat = 0
    var title: String = "food"
    
    var detailedView: Bool = false
}

struct CageActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "Keep the cage or tray clean. You can set up a reminder in the settings"
    
    var offset: CGFloat = 0
    var title: String = "cage"
    
    var detailedView: Bool = false
}

struct ClawsActivity: Activity {
    
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "Keep track of the length of the claws for your pet's comfort"
    
    var offset: CGFloat = 0
    var title: String = "claws"
    
    var detailedView: Bool = false
}

struct TrainingActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Well done!"
    
    var description: String = "Exercise your pet's brain. You can rate your workout and add a description to track your progress"
    
    var offset: CGFloat = 0
    var title: String = "training"
    
    var detailedView: Bool = false
}

struct ParasitesActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "Treat your pet from external and internal parasites in time. Add a photo or name of the drug used"
    
    var offset: CGFloat = 0
    var title: String = "parasites"
    
    var detailedView: Bool = false
}

struct PeeActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "Track urinary frequency, especially if your pet is having problems. If urine contains impurities, add a photo to show to the vet"
    
    var offset: CGFloat = 0
    var title: String = "pee"
    
    var detailedView: Bool = false
}

struct PillsActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "If your pet needs to take medications, mark so as not to forget. You can customize the list of drugs taken in the settings"
    
    var offset: CGFloat = 0
    var title: String = "pills"
    
    var detailedView: Bool = false
}

struct PooActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "Monitor the frequency and quality of the poop. If it differs from usual, you can take a photo or video to show to the veterinarian."
     
    var offset: CGFloat = 0
    var title: String = "poo"
    
    var detailedView: Bool = false
}

struct VaccineActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "If your pet needs vaccinations, set yourself a reminder so you don't forget. Because it matters"
    
    var offset: CGFloat = 0
    var title: String = "vaccine"
    
    var detailedView: Bool = false
}

struct VomitActivity: Activity {
    var popupUndetailedTitle: String = "Ugggh!"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "Sometimes vomiting is normal. But it is better to write down all cases and take a photo to show to the veterinarian."
    
    var offset: CGFloat = 0
    var title: String = "vomit"
    
    var detailedView: Bool = false
}


struct WalkingActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Info saved to journal"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "Record all of your walks with your pet and watch your activity to ensure it gets the necessary physical activity"
    
    var offset: CGFloat = 0
    var title: String = "walk"
    
    var detailedView: Bool = false
}

struct WashingActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Info saved to journal"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "If your pet is unable to keep its coat and skin clean on its own, you can set a reminder for yourself."
    
    var offset: CGFloat = 0
    var title: String = "washing"
    
    var detailedView: Bool = false
}

struct WaterActivity: Activity {
    var popupUndetailedTitle: String = "Mmm, water!"
    var popupDetailedTitle: String = "Mmm, water!"
    var popupUndetailedDescription: String = "Info saved to journal"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "If your pet is unable to keep its coat and skin clean on its own, you can set a reminder for yourself."
    
    var offset: CGFloat = 0
    var title: String = "water"
    
    var detailedView: Bool = false
}

struct WeightActivity: Activity {
    var popupUndetailedTitle: String = "Un Title"
    var popupDetailedTitle: String = "Detailed Title"
    var popupUndetailedDescription: String = "Undetailed descritpion"
    var popupDetailedDescription: String = "Detailed description"
    var popupButton: String = "Done"
    
    var description: String = "It is very important to monitor the weight of the animal. Add weighting and track weight loss statistics."
    
    var offset: CGFloat = 0
    var title: String = "weight"
    
    var detailedView: Bool = false
}*/
/*
func getActivityByTitle(string: String) -> some Activity {
    switch string {
    case "cage": return CageActivity()
    case "claws": return ClawsActivity()
    case "food": return FoodActivity()
    case "parasites": return ParasitesActivity()
    case "pee": return PeeActivity()
    case "pills": return PillsActivity()
    case "poo": return PooActivity()
    case "training": return TrainingActivity()
    case "vaccine": return VaccineActivity()
    case "vomit": return VomitActivity()
    case "walk": return WalkingActivity()
    case "washing": return WashingActivity()
    case "water": return WaterActivity()
    case "weight": return WeightActivity()
    default:
        return PooActivity()
    }
}
*/
/*
func getActivityByTitle<T: Activity>(string: String) -> T {
    switch string {
    case "cage": return CageActivity() as! T
    case "claws": return ClawsActivity() as! T
    case "food": return FoodActivity() as! T
    case "parasites": return ParasitesActivity() as! T
    case "pee": return PeeActivity() as! T
    case "pills": return PillsActivity() as! T
    case "poo": return PooActivity() as! T
    case "training": return TrainingActivity() as! T
    case "vaccine": return VaccineActivity() as! T
    case "vomit": return VomitActivity() as! T
    case "walk": return WalkingActivity() as! T
    case "washing": return WashingActivity() as! T
    case "water": return WaterActivity() as! T
    case "weight": return WeightActivity() as! T
    default:
        return PooActivity() as! T
    }
}*/



/*
func getActivityByTitle(string: String) -> Activity {
    switch string {
    case "cage": return Activity(title: "cage",
                                       detailedView: false,
                                       offset: 0,
                                       description: "",
                                       popupUndetailedTitle: "",
                                       popupDetailedTitle: "",
                                       popupUndetailedDescription: "",
                                       popupDetailedDescription: "",
                                       popupButton: "")
    case "claws": return Activity(title: "claws",
                                        detailedView: false,
                                        offset: 0,
                                        description: "",
                                        popupUndetailedTitle: "",
                                        popupDetailedTitle: "",
                                        popupUndetailedDescription: "",
                                        popupDetailedDescription: "",
                                        popupButton: "")
    case "food": return Activity(title: "food",
                                       detailedView: false,
                                       offset: 0,
                                       description: "",
                                       popupUndetailedTitle: "",
                                       popupDetailedTitle: "",
                                       popupUndetailedDescription: "",
                                       popupDetailedDescription: "",
                                       popupButton: "")
    case "parasites": return Activity(title: "parasites",
                                            detailedView: false,
                                            offset: 0,
                                            description: "",
                                            popupUndetailedTitle: "",
                                            popupDetailedTitle: "",
                                            popupUndetailedDescription: "",
                                            popupDetailedDescription: "",
                                            popupButton: "")
    case "pee": return Activity(title: "pee",
                                      detailedView: false,
                                      offset: 0,
                                      description: "",
                                      popupUndetailedTitle: "",
                                      popupDetailedTitle: "",
                                      popupUndetailedDescription: "",
                                      popupDetailedDescription: "",
                                      popupButton: "")
    case "pills": return Activity(title: "pills",
                                        detailedView: false,
                                        offset: 0,
                                        description: "",
                                        popupUndetailedTitle: "",
                                        popupDetailedTitle: "",
                                        popupUndetailedDescription: "",
                                        popupDetailedDescription: "",
                                        popupButton: "")
    case "poo": return Activity(title: "poo",
                                      detailedView: false,
                                      offset: 0,
                                      description: "",
                                      popupUndetailedTitle: "",
                                      popupDetailedTitle: "",
                                      popupUndetailedDescription: "",
                                      popupDetailedDescription: "",
                                      popupButton: "")
    case "training": return Activity(title: "training",
                                           detailedView: false,
                                           offset: 0,
                                           description: "",
                                           popupUndetailedTitle: "",
                                           popupDetailedTitle: "",
                                           popupUndetailedDescription: "",
                                           popupDetailedDescription: "",
                                           popupButton: "")
    case "vaccine": return Activity(title: "vaccine",
                                          detailedView: false,
                                          offset: 0,
                                          description: "",
                                          popupUndetailedTitle: "",
                                          popupDetailedTitle: "",
                                          popupUndetailedDescription: "",
                                          popupDetailedDescription: "",
                                          popupButton: "")
    case "vomit": return Activity(title: "vomit",
                                        detailedView: false,
                                        offset: 0,
                                        description: "",
                                        popupUndetailedTitle: "",
                                        popupDetailedTitle: "",
                                        popupUndetailedDescription: "",
                                        popupDetailedDescription: "",
                                        popupButton: "")
    case "walk": return Activity(title: "walk",
                                       detailedView: false,
                                       offset: 0,
                                       description: "",
                                       popupUndetailedTitle: "",
                                       popupDetailedTitle: "",
                                       popupUndetailedDescription: "",
                                       popupDetailedDescription: "",
                                       popupButton: "")
    case "washing": return Activity(title: "washing",
                                          detailedView: false,
                                          offset: 0,
                                          description: "",
                                          popupUndetailedTitle: "",
                                          popupDetailedTitle: "",
                                          popupUndetailedDescription: "",
                                          popupDetailedDescription: "",
                                          popupButton: "")
    case "water": return Activity(title: "water",
                                        detailedView: false,
                                        offset: 0,
                                        description: "",
                                        popupUndetailedTitle: "",
                                        popupDetailedTitle: "",
                                        popupUndetailedDescription: "",
                                        popupDetailedDescription: "",
                                        popupButton: "")
    case "weight": return Activity(title: "weight",
                                         detailedView: false,
                                         offset: 0,
                                         description: "",
                                         popupUndetailedTitle: "",
                                         popupDetailedTitle: "",
                                         popupUndetailedDescription: "",
                                         popupDetailedDescription: "",
                                         popupButton: "")
    default:
        return Activity(title: "weight",
                              detailedView: false,
                              offset: 0,
                              description: "",
                              popupUndetailedTitle: "",
                              popupDetailedTitle: "",
                              popupUndetailedDescription: "",
                              popupDetailedDescription: "",
                              popupButton: "")
    }
}
    */

