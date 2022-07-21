//
//  KeywordManager.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import CoreData
import UIKit

final class KeywordManager {
    
    // MARK: - properties
    
    static var shared: KeywordManager = KeywordManager()
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    // MARK: - init
    
    private init() { }
    
    // MARK: - func
    
    func loadFromCoreData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        guard let context = self.context else { return [] }
        do {
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveRecentSearch(keyword: String) {
        guard let context = self.context,
              let entity = NSEntityDescription.entity(forEntityName: "Keywords", in: context),
              let recentTerms = NSManagedObject(entity: entity, insertInto: context) as? Keywords
        else { return }
        
        recentTerms.term = keyword

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @discardableResult
    func delete<T: NSManagedObject>(at keyword: String, request: NSFetchRequest<T>) -> Bool {
        request.predicate = NSPredicate(format: "keyword = %@", NSString(string: keyword))

        do {
            if let recentTerms = try context?.fetch(request) {
                if recentTerms.count == 0 { return false }
                context?.delete(recentTerms[0])
                try context?.save()
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }

        return false
    }
    
    @discardableResult
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context?.execute(delete)
            return true
        } catch {
            return false
        }
    }
}
