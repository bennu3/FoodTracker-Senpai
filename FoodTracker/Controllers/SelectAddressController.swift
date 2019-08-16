//
//  SelectAddressController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/15/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

protocol SelectAddressControllerDelegate: AnyObject {
    func selectAddressController(_ selectAddressController: SelectAddressController, didSelectAddress address: Address)
}

class SelectAddressController: UITableViewController {
    
    var addresses: [Address] = []
    weak var delegate: SelectAddressControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row].name
        cell.detailTextLabel?.text = addresses[indexPath.row].cityCountry
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addresses[indexPath.row]
        delegate?.selectAddressController(self, didSelectAddress: address)
    }
    
}
