//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 28/10/2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantHeaderView!
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: {
            guard let rating = segue.identifier else { return }
            self.headerView.ratingImageView.image = UIImage(named: rating)
            self.scaleRatingImageViewUpTransFrom()
            self.animatedlyShowRatingImageView()
            self.saveRating(rating)
        })
    }

    var restaurant: RestaurantMO!

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        // 預設 .always，會自動調整 Table view content 的位置
        tableView.contentInsetAdjustmentBehavior = .never

        self.setHeaderView()
        self.setNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    //MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 5 }

    //MARK: - Table view delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailViewCell.self),
                                                     for: indexPath) as! RestaurantDetailViewCell

            cell.iconImageView.image = UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = restaurant.phone
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailViewCell.self),
                                                     for: indexPath) as! RestaurantDetailViewCell

            cell.iconImageView.image = UIImage(systemName: "location")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = restaurant.location
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDescriptionCell.self),
                                                     for: indexPath) as! RestaurantDescriptionCell

            cell.descriptionLabel.text = restaurant.summary
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailSeparatorCell.self),
                                                     for: indexPath) as! RestaurantDetailSeparatorCell

            cell.titleLabel?.text = "How to get there"
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self),
                                                     for: indexPath) as! RestaurantDetailMapCell

            if let restaurantLocation = restaurant.location {
                cell.configure(location: restaurantLocation)
            }
            
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMap":
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
        case "showReview":
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = restaurant
        default:
            fatalError("* There is no any segue.")
        }
    }

    //MARK: - Private methods
    private func setHeaderView() {
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
        if let restaurantImage = restaurant.image {
            headerView.headerImageView.image = UIImage(data: restaurantImage as Data)
        }
        
        if let restaurantRating = restaurant.rating {
            headerView.ratingImageView.image = UIImage(named: restaurantRating)
        }
    }

    private func setNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = .white
    }

    private func scaleRatingImageViewUpTransFrom() {
        let scaleUpTransFrom = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.headerView.ratingImageView.transform = scaleUpTransFrom
        self.headerView.ratingImageView.alpha = 0
    }

    private func animatedlyShowRatingImageView() {
        UIView.animate(withDuration: 0.4,
                       animations: {
                           self.headerView.ratingImageView.transform = .identity
                           self.headerView.ratingImageView.alpha = 1
                       })
    }
    
    private func saveRating(_ rating: String) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.restaurant.rating = rating
            appDelegate.saveContext()
        }
    }
}
