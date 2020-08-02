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

    var restaurant = Restaurant()

    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        setHeaderView()
    }

    //MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }

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

            cell.descriptionLabel.text = restaurant.description
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    //MARK: - Private methods
    private func setHeaderView() {
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
    }
}
