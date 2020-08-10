//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 28/10/2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurants: [RestaurantMO] = []
    
    //MARK: - UI
    @IBOutlet var emptyImageView: UIImageView!
    
    //MARK: - Actions
    @IBAction func undoToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.backgroundView = emptyImageView
        tableView.backgroundView?.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = (restaurants.count > 0) ? true : false
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundView?.isHidden = (restaurants.count > 0) ? true : false
        tableView.separatorStyle = (restaurants.count > 0) ? .singleLine : .none
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.heartImageView.isHidden = restaurants[indexPath.row].isVisited ? false : true
        if let thumbnailImage = restaurants[indexPath.row].image {
            cell.thumbnailImageView.image = UIImage(data: thumbnailImage as Data)
        }

        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            // Delete the row from the data source
            self.restaurants.remove(at: indexPath.row)

            self.tableView.deleteRows(at: [indexPath], with: .fade)

            // Call completion handler with true to indicate
            completionHandler(true)
        }

        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            guard let restaurantName = self.restaurants[indexPath.row].name else { return }
            guard let restaurantImage = self.restaurants[indexPath.row].image else { return }
            let defaultText = "Just checking in at " + restaurantName
            let activityController: UIActivityViewController
            if let imageToShare = UIImage(data: restaurantImage as Data) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }

            // For iPad
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }

            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }

        // Customize the color
        deleteAction.backgroundColor = UIColor(red: 231, green: 76, blue: 60)
        deleteAction.image = UIImage(systemName: "trash")

        shareAction.backgroundColor = UIColor(red: 254, green: 149, blue: 38)
        shareAction.image = UIImage(systemName: "square.and.arrow.up")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])

        return swipeConfiguration
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in

            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.restaurants[indexPath.row].isVisited = self.restaurants[indexPath.row].isVisited ? false : true
            cell.heartImageView.isHidden = self.restaurants[indexPath.row].isVisited ? false : true

            completionHandler(true)
        }

        let checkInIcon = restaurants[indexPath.row].isVisited ? "arrow.uturn.left" : "checkmark"
        checkInAction.backgroundColor = UIColor(red: 38, green: 162, blue: 78)
        checkInAction.image = UIImage(systemName: checkInIcon)

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])


        return swipeConfiguration
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }

    //MARK: - Private methods
    private func setNavigationBar() {
        guard let customFont = UIFont(name: "Rubik-Medium", size: 40.0) else { return }
        navigationController?.navigationBar.prefersLargeTitles = true
        // shadow image 是 navigation bar 下方那一條線
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
            NSAttributedString.Key.font: customFont
        ]
    }

}
