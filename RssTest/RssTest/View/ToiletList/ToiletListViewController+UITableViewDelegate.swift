//
//  ToiletListViewController+UITableViewDelegate.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation
import UIKit

extension ToiletListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.displayToiletDetailView()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
