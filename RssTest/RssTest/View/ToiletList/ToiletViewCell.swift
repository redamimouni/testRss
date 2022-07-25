//
//  ToiletViewCell.swift
//  RssTest
//
//  Created by Reda Mimouni on 25/07/2022.
//

import Foundation
import UIKit

class ToiletViewCell: UITableViewCell {
    // MARK: - Subviews

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private lazy var openingHourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private lazy var isAccessiblePrmImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "prm")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(addressLabel)
        contentView.addSubview(openingHourLabel)
        contentView.addSubview(isAccessiblePrmImage)
        contentView.addSubview(distanceLabel)
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Reusable

    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }

    // MARK: - Private

    private func resetCell() {
        addressLabel.text = ""
        openingHourLabel.text = ""
        distanceLabel.text = ""
        isAccessiblePrmImage.isHidden = true
    }

    // MARK: - Configure

    func fill(with viewModel: ToiletViewModel) {
        addressLabel.text = viewModel.address
        openingHourLabel.text = viewModel.openingHour
        distanceLabel.text = viewModel.distance
        isAccessiblePrmImage.isHidden = !viewModel.isPrmFriendly
    }

    // MARK: - Constraints

    private func setConstraints() {
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            addressLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: .padding),
            addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: .paddingSmall),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding),

            openingHourLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: .paddingSmall),
            openingHourLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),

            distanceLabel.topAnchor.constraint(equalTo: openingHourLabel.bottomAnchor, constant: .paddingSmall),
            distanceLabel.leadingAnchor.constraint(equalTo: openingHourLabel.leadingAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding),

            isAccessiblePrmImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding),
            isAccessiblePrmImage.widthAnchor.constraint(equalToConstant: 20),
            isAccessiblePrmImage.heightAnchor.constraint(equalToConstant: 20),
            isAccessiblePrmImage.topAnchor.constraint(equalTo: openingHourLabel.topAnchor),
            isAccessiblePrmImage.leadingAnchor.constraint(equalTo: openingHourLabel.trailingAnchor),
            isAccessiblePrmImage.bottomAnchor.constraint(equalTo: openingHourLabel.bottomAnchor)
        ])
    }
}
