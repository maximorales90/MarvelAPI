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
    var imageData: Data? = nil
    
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
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let personajeSubtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.numberOfLines = 4
        subtitle.font = .systemFont(ofSize: 12, weight: .light)
        return subtitle
    }()
    
    let personajeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
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

        personajeImageView.frame = CGRect(x: 15, y: 6, width: 150 , height: 150)
        personajeTitleLabel.frame = CGRect(x: 184, y: 0, width: contentView.frame.size.width-196 , height: 60)
        
        personajeSubtitleLabel.frame = CGRect(x: 184, y: 50, width: contentView.frame.size.width-196 , height: contentView.frame.size.height/2)




//        personajeTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width-170 , height: 60)
//        personajeSubtitleLabel.frame = CGRect(x: 10, y: 50, width: contentView.frame.size.width-170 , height: contentView.frame.size.height/2)
//        personajeImageView.frame = CGRect(x: contentView.frame.size.width-160, y: 5, width: 150 , height: contentView.frame.size.height-10)

        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        personajeTitleLabel.text = nil
        personajeSubtitleLabel.text = nil
        personajeImageView.image = nil
    }
    
    func configure(with viewModel: PersonsajesCellViewModel ){
        personajeTitleLabel.text = viewModel.title
        personajeSubtitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            personajeImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else{
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.personajeImageView.image = UIImage(data: data)
                }
            } .resume()
        }
    }
}
