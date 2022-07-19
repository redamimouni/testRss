//
//  ToiletListViewController+UITableViewDataSource.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation
import UIKit

extension ToiletListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        return cell
    }


}
