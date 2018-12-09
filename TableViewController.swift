//
//  TableViewController.swift
//  Vernam's_cypher
//
//  Created by Константин on 02/12/2018.
//  Copyright © 2018 Konstantin Samsonov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var textArrayTwo = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        readFromFile()
    //    print(textArrayTwo)
    }
    
    func readFromFile () {
        if let path = Bundle.main.path(forResource: "cypher", ofType: "txt"){
            if let text = try? String(contentsOfFile:  path) {
                textArrayTwo = text.components(separatedBy: "\n")
            }
        }
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArrayTwo.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Блокнот номер \(indexPath.row + 1)"
        return cell
    }

 //   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   // }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! CypherViewController
                dvc.text = textArrayTwo[indexPath.row]
        }
            
        }
    }
}

