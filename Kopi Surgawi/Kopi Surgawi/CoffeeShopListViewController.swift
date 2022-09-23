//
//  CoffeeShopListViewController.swift
//  Kopi Surgawi
//
//  Created by aldybuana on 19/09/22.
//

import UIKit

class CoffeeShopListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var coffeeshopNames = ["Boja Eatery", "Brewery Coffee", "Casadela Coffee", "Dago Terrace", "Hola Koffie", "Imah Kai", "Jiwan Kopi", "Kilogram Space", "Masagi Coffee", "Nannys Pavillion", "Sabana Kopi", "Sini Kupi", "Sonowae Kopi", "Starbuck Coffee", "Urra Cafe"]

    var coffeeshopImage = ["bojaeatery", "brewery", "casadela", "dagoterrace", "holakoffie", "imahkai", "jiwan", "kilogram", "masagi", "nannys", "sabanakopi", "sinikupi", "sonowae", "starbuck", "urracafe"]

    var coffeeshopLocations = ["Jl. Pungkur", "Jl. Buahbatu", "Jl. Asia Afrika", "Jl. Sudirman", "Jl. Setiabudi", "Jl. Boscha", "Jl. Sukabumi", "Jl. Soekarno Hatta", "Jl. Kopo", "Jl. Dago", "Jl. Cibiru", "Jl. Aceh", "Jl. Cihapit", "Jl. Gandapura", "Jl. Riau"]

    var coffeeshopTypes = ["Coffeeshop / Cafe", "Tea House", "Cafe Shop", "Home Coffee", "Coffeeshop / Cafe", "Tea House", "Cafe", "Home Coffee", "Bakery / Cafe", "Tea House / Cafe", "Coffeeshop / Bakery", "Coffeeshop / Milk House", "Coffeeshop / Cafe", "Bakery", "Warmindo"]
    
    var favoritedCoffeeshops: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeshopNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeShopCellId", for: indexPath) as! CoffeeShopViewCell
        
        cell.thumbImageView.image = UIImage(named: coffeeshopImage[indexPath.row])
        cell.nameLabel.text = coffeeshopNames[indexPath.row]
        cell.addressLabel.text = coffeeshopLocations[indexPath.row]
        cell.categoryLabel.text = coffeeshopTypes[indexPath.row]
        
        cell.thumbFavorited.isHidden = self.favoritedCoffeeshops.contains(where: { Index in return Index == indexPath.row }) ? false : true
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func reserveTable(_ index: Int){
        let alert = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. \nPlease try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func toggleFavorite(_ index: Int){
        
        // check ada indexPath.row atau tidak di dalam data array favoritedCoffeeShop
        if favoritedCoffeeshops.contains(index) {
            // Jika ada, remove dari favoritedCoffeeShop
            if let index = favoritedCoffeeshops.firstIndex(of: index) {
                favoritedCoffeeshops.remove(at: index)
            }
        } else {
            // kalau ada , insert index
            favoritedCoffeeshops.append(index)
        }
        //let checkFav = favoritedCoffeeshops.firstIndex(of: index) ? favoritedCoffeeshops.remove(at: index) : favoritedCoffeeshops.append(index)
        //        let checkFavorite = favoritedCoffeeshops.remove(at: index)
//        favoritedCoffeeshops.contains(where: { Index in return Index == firstIndex }) ? favoritedCoffeeshops.remove(at: index) : favoritedCoffeeshops.append(index)
        
        
//        favoritedCoffeeshops.append(index)
        //tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.none)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Reserve a table", style: UIAlertAction.Style.default, handler: { alert in
            self.reserveTable(indexPath.row)
        }))
        
        let checkTitleFavorite = favoritedCoffeeshops.contains(where: { Index in return Index == indexPath.row }) ? "Remove from favorite" : "Mark as favorite"
        
        
        actionSheet.addAction(UIAlertAction(title: checkTitleFavorite, style: .default, handler: { _ in
            self.toggleFavorite(indexPath.row)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        
        present(actionSheet, animated: true)
        
    }
    
}
