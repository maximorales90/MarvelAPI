//
//  PersonajesCell.swift
//  MarvelAPI
//
//  Created by Maximiliano Morales on 16/03/2022.
//
import UIKit
import Foundation

class PersonsajesCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    let imageData: Data? = nil
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
    ){
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
}

class PersonajesCell: UITableViewCell {
    
    static let identifier = "PersonajesCell"
    
    let personajeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    let personajeSubtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.font = .systemFont(ofSize: 18, weight: .medium)
        return subtitle
    }()
    
    let personajeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personajeTitleLabel)
        contentView.addSubview(personajeSubtitleLabel)
        contentView.addSubview(personajeImageView)

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        personajeTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width-120 , height: contentView.frame.size.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: PersonsajesCellViewModel ){
        personajeTitleLabel.text = viewModel.title
        personajeSubtitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            personajeImageView.image = UIImage(data: data)
        }
        else{
//            fetch
        }
    }
}
