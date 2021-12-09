//
//  BikeRide+CoreDataProperties.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 10.09.2021.
//

import Foundation
import CoreData
import CoreLocation

@objc(BikeRide)
public class BikeRide: NSManagedObject {

}

extension BikeRide {
    
    

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BikeRide> {
        return NSFetchRequest<BikeRide>(entityName: "BikeRide")
    }
    
    // Fetch requests for bike rides in specific date ranges - returns an array of optionals
    @nonobjc public class func fetchRequestsWithDateRanges() -> [NSFetchRequest<BikeRide>?] {
        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        let startOfToday = calendar.startOfDay(for: Date())
        let endOfToday = calendar.date(byAdding: .day, value: 1, to: startOfToday)
        
        var requests: [NSFetchRequest<BikeRide>?] = []
        
        // 0: Past 7 days
        let request1: NSFetchRequest<BikeRide> = BikeRide.fetchRequest()
        request1.sortDescriptors = []
        
        let dateFrom1 = calendar.date(byAdding: .day, value: -6, to: startOfToday)

        if let date1 = dateFrom1, let date2 = endOfToday {
            // Set predicate to range of accepted dates
            let fromPredicate = NSPredicate(format: "%@ <= %K", date1 as NSDate, #keyPath(BikeRide.cyclingStartTime))
            let toPredicate = NSPredicate(format: "%K <= %@", #keyPath(BikeRide.cyclingStartTime), date2 as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request1.predicate = datePredicate
            requests.append(request1)
        }
        else {
            // Insert nil for this entry if unwrapping didn't work
            requests.append(nil)
        }
        
        // 1: Past 14 - 7 days
        let request2: NSFetchRequest<BikeRide> = BikeRide.fetchRequest()
        request2.sortDescriptors = []
        
        let dateTo2 = calendar.date(byAdding: .day, value: -7, to: startOfToday)
        let dateFrom2 = calendar.date(byAdding: .day, value: -13, to: startOfToday)

        if let date1 = dateFrom2, let date2 = dateTo2 {
            // Set predicate to range of accepted dates
            let fromPredicate = NSPredicate(format: "%@ <= %K", date1 as NSDate, #keyPath(BikeRide.cyclingStartTime))
            let toPredicate = NSPredicate(format: "%K <= %@", #keyPath(BikeRide.cyclingStartTime), date2 as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request2.predicate = datePredicate
            requests.append(request2)
        }
        else {
            // Insert nil for this entry if unwrapping didn't work
            requests.append(nil)
        }
        
        // 2: Past 5 weeks
        let request3: NSFetchRequest<BikeRide> = BikeRide.fetchRequest()
        request3.sortDescriptors = []
        
        let dateFrom3 = calendar.date(byAdding: .day, value: -34, to: startOfToday)

        if let date1 = dateFrom3, let date2 = endOfToday {
            // Set predicate to range of accepted dates
            let fromPredicate = NSPredicate(format: "%@ <= %K", date1 as NSDate, #keyPath(BikeRide.cyclingStartTime))
            let toPredicate = NSPredicate(format: "%K <= %@", #keyPath(BikeRide.cyclingStartTime), date2 as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request3.predicate = datePredicate
            requests.append(request3)
        }
        else {
            // Insert nil for this entry if unwrapping didn't work
            requests.append(nil)
        }
        
        // 3: Past 10 - 5 weeks
        let request4: NSFetchRequest<BikeRide> = BikeRide.fetchRequest()
        request4.sortDescriptors = []
        
        let dateTo4 = calendar.date(byAdding: .day, value: -35, to: startOfToday)
        let dateFrom4 = calendar.date(byAdding: .day, value: -69, to: startOfToday)

        if let date1 = dateFrom4, let date2 = dateTo4 {
            // Set predicate to range of accepted dates
            let fromPredicate = NSPredicate(format: "%@ <= %K", date1 as NSDate, #keyPath(BikeRide.cyclingStartTime))
            let toPredicate = NSPredicate(format: "%K <= %@", #keyPath(BikeRide.cyclingStartTime), date2 as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request4.predicate = datePredicate
            requests.append(request4)
        }
        else {
            // Insert nil for this entry if unwrapping didn't work
            requests.append(nil)
        }
        
        // 4: Past 30 weeks
        let request5: NSFetchRequest<BikeRide> = BikeRide.fetchRequest()
        request5.sortDescriptors = []
        
        let dateFrom5 = calendar.date(byAdding: .day, value: -209, to: startOfToday)

        if let date1 = dateFrom5, let date2 = endOfToday {
            // Set predicate to range of accepted dates
            let fromPredicate = NSPredicate(format: "%@ <= %K", date1 as NSDate, #keyPath(BikeRide.cyclingStartTime))
            let toPredicate = NSPredicate(format: "%K <= %@", #keyPath(BikeRide.cyclingStartTime), date2 as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request5.predicate = datePredicate
            requests.append(request5)
        }
        else {
            // Insert nil for this entry if unwrapping didn't work
            requests.append(nil)
        }
        
        // 5: Past 60 - 30 weeks
        let request6: NSFetchRequest<BikeRide> = BikeRide.fetchRequest()
        request6.sortDescriptors = []
        
        let dateTo6 = calendar.date(byAdding: .day, value: -210, to: startOfToday)
        let dateFrom6 = calendar.date(byAdding: .day, value: -419, to: startOfToday)

        if let date1 = dateFrom6, let date2 = dateTo6 {
            // Set predicate to range of accepted dates
            let fromPredicate = NSPredicate(format: "%@ <= %K", date1 as NSDate, #keyPath(BikeRide.cyclingStartTime))
            let toPredicate = NSPredicate(format: "%K <= %@", #keyPath(BikeRide.cyclingStartTime), date2 as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request6.predicate = datePredicate
            requests.append(request6)
        }
        else {
            // Insert nil for this entry if unwrapping didn't work
            requests.append(nil)
        }
        
        return requests
    }

    @NSManaged public var cyclingLatitudes: [CLLocationDegrees]
    @NSManaged public var cyclingLongitudes: [CLLocationDegrees]
    @NSManaged public var cyclingSpeeds: [CLLocationSpeed]
    @NSManaged public var cyclingElevations: [CLLocationDistance]
    @NSManaged public var cyclingDistance: Double
    @NSManaged public var cyclingStartTime: Date
    @NSManaged public var cyclingTime: Double
    @NSManaged public var cyclingRouteName: String
    @NSManaged public var id_: UUID
    
    public var id: UUID {
        get { id_ } // TODO: maybe protect against when app ships?
        set { id_ = newValue }
    }
    
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<BikeRide> {
        let request = NSFetchRequest<BikeRide>(entityName: "BikeRide")
        request.sortDescriptors = [NSSortDescriptor(key: "id_", ascending: true)]
        request.predicate = predicate
        return request
    }

    static func sortByDistance(list: [BikeRide], ascending: Bool) -> [BikeRide] {
        var returnList: [BikeRide] = list
        for i in 0..<returnList.count {
            var current = i
            for j in i..<returnList.count {
                if (ascending && returnList[j].cyclingDistance < returnList[current].cyclingDistance) {
                    current = j
                }
                else if (!ascending && returnList[j].cyclingDistance > returnList[current].cyclingDistance) {
                    current = j
                }
            }
            let temp: BikeRide = returnList[current]
            returnList[current] = returnList[i]
            returnList[i] = temp
        }
        return returnList
    }
    
    static func sortByDate(list: [BikeRide], ascending: Bool) -> [BikeRide] {
        var returnList: [BikeRide] = []

        let bikeRideDates: [Date] = list.map { $0.cyclingStartTime }

        let bikeRideDateTuples = zip(list, bikeRideDates)
        
        if (ascending) {
            returnList = bikeRideDateTuples.sorted { $0.1 < $1.1 }
                .map {$0.0}
        }
        else {
            returnList = bikeRideDateTuples.sorted { $0.1 > $1.1 }
                .map {$0.0}
        }
        return returnList
    }
    
    static func sortByTime(list: [BikeRide], ascending: Bool) -> [BikeRide] {
        var returnList: [BikeRide] = list
        for i in 0..<returnList.count {
            var current = i
            for j in i..<returnList.count {
                if (ascending && returnList[j].cyclingTime < returnList[current].cyclingTime) {
                    current = j
                }
                else if (!ascending && returnList[j].cyclingTime > returnList[current].cyclingTime) {
                    current = j
                }
            }
            let temp: BikeRide = returnList[current]
            returnList[current] = returnList[i]
            returnList[i] = temp
        }
        return returnList
    }
}

extension BikeRide : Identifiable {
    static var savedBikeRidesFetchRequest: NSFetchRequest<BikeRide> {
        let request: NSFetchRequest<BikeRide> = BikeRide.fetchRequest()
        request.sortDescriptors = []

        return request
      }
}

extension BikeRide {
    
    static func allBikeRides() -> [BikeRide] {
        let context = CoreDataManager.shared.viewContext
        let fetchRequest: NSFetchRequest<BikeRide> = BikeRide.fetchRequest()
        do {
            let items = try context.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting BikeRides: \(error.localizedDescription), \(error.userInfo)")
        }
        return [BikeRide]()
    }
    
    static func allBikeRidesSorted() -> [BikeRide] {
        let bikeRidesUnsorted = allBikeRides()
        //let context = CoreDataManager.shared.viewContext
        //let fetchRequest: NSFetchRequest<UserPreferences> = UserPreferences.fetchRequest()
        do {
           // let preferences = try context.fetch(fetchRequest)
            var bikeRides: [BikeRide] = []
            bikeRides = BikeRide.sortByDate(list: bikeRidesUnsorted, ascending: false)
            /* switch preferences[0].sortingChoiceConverted {
            case .distanceAscending:
                bikeRides = BikeRide.sortByDistance(list: bikeRidesUnsorted, ascending: true)
            case .distanceDescending:
                bikeRides = BikeRide.sortByDistance(list: bikeRidesUnsorted, ascending: false)
            case .dateAscending:
                bikeRides = BikeRide.sortByDate(list: bikeRidesUnsorted, ascending: true)
            case .dateDescending:
                bikeRides = BikeRide.sortByDate(list: bikeRidesUnsorted, ascending: false)
            case .timeAscending:
                bikeRides = BikeRide.sortByTime(list: bikeRidesUnsorted, ascending: true)
            case .timeDescending:
                bikeRides = BikeRide.sortByTime(list: bikeRidesUnsorted, ascending: false)
            }*/
            return bikeRides
        }
       /* catch let error as NSError {
            print("Error getting BikeRides: \(error.localizedDescription), \(error.userInfo)")
        }*/
       // return [BikeRide]()
    }
    
    static func allRouteNames() -> [String] {
        let allBikeRides = allBikeRides()
        var uniqueNames: [String] = []

        for ride in allBikeRides {
            if (uniqueNames.firstIndex(of: ride.cyclingRouteName) == nil) {
                if (ride.cyclingRouteName != "Uncategorized") {
                    uniqueNames.append(ride.cyclingRouteName)
                }
            }
        }
        
        return uniqueNames.sorted { $0.lowercased() < $1.lowercased() }
    }
    
    static func allCategories() -> [Category] {
        let allBikeRides = allBikeRidesSorted()
        var categories: [Category] = []
        var names: [String] = []
        var numbers: [Int] = []
        var uncategorizedCounter = 0
        
        for ride in allBikeRides {
            if (names.firstIndex(of: ride.cyclingRouteName) == nil) {
                if (ride.cyclingRouteName != "Uncategorized") {
                    names.append(ride.cyclingRouteName)
                    numbers.append(1)
                }
                else {
                    uncategorizedCounter += 1
                }
            }
            else {
                numbers[names.firstIndex(of: ride.cyclingRouteName)!] += 1
            }
        }
        
        for (index, name) in names.enumerated() {
            categories.append(Category(name: name, number: numbers[index]))
        }
        
        // Sort the user created categories alphabeticaly
        categories = categories.sorted { $0.name.lowercased() < $1.name.lowercased() }
        
        if (uncategorizedCounter > 0) {
            categories.insert(Category(name: "Uncategorized", number: uncategorizedCounter), at: 0)
        }
        
        if (allBikeRides.count > 0) {
            categories.insert(Category(name: "All", number: allBikeRides.count), at: 0)
        }
        
        return categories
    }
    
    // Functions to get data for the charts on the statistics tab
    static func bikeRidesInPastWeek() -> [BikeRide] {
        let context = CoreDataManager.shared.viewContext
        let fetchRequest: NSFetchRequest<BikeRide> = BikeRide.fetchRequestsWithDateRanges()[0] ?? BikeRide.fetchRequest()
        do {
            let items = try context.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting BikeRides: \(error.localizedDescription), \(error.userInfo)")
        }
        return [BikeRide]()
    }
    
    static func bikeRidesInPast5Weeks() -> [BikeRide] {
        let context = CoreDataManager.shared.viewContext
        let fetchRequest: NSFetchRequest<BikeRide> = BikeRide.fetchRequestsWithDateRanges()[2] ?? BikeRide.fetchRequest()
        do {
            let items = try context.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting BikeRides: \(error.localizedDescription), \(error.userInfo)")
        }
        return [BikeRide]()
    }
    
    static func bikeRidesInPast30Weeks() -> [BikeRide] {
        let context = CoreDataManager.shared.viewContext
        let fetchRequest: NSFetchRequest<BikeRide> = BikeRide.fetchRequestsWithDateRanges()[4] ?? BikeRide.fetchRequest()
        do {
            let items = try context.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting BikeRides: \(error.localizedDescription), \(error.userInfo)")
        }
        return [BikeRide]()
    }
}
