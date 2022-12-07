//
//  ArtistAnnotationView.swift
//  Smilee
//
//  Created by Ashvin Gudaliya on 09/06/21.
//

import UIKit
import MapKit

class MapAnnotationView: MKAnnotationView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        
        guard let nibView = loadViewFromNib() else {
            return
        }
        
        self.contentView = nibView
        backgroundColor = UIColor.clear
        contentView?.backgroundColor = UIColor.clear
        
        imageView.cornerRadius = 17
        imageView.borderWidth = 1
        //imageView.borderColor = UIColor.white
        
        /*containerView.shadowColor = UIColor.black.withAlphaComponent(0.2)
        containerView.shadowOpacity = 1
        containerView.shadowOffset = CGSize(width: 0, height: 5)
        containerView.shadowRadius = 15*/
        containerView.backgroundColor = .clear
        
        bounds = nibView.frame
        addSubview(nibView)
        
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        containerView?.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        containerView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let name =  "MapAnnotationView"
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bounds = containerView!.bounds
    }
    override func prepareForReuse() {
        super.layoutSubviews()
        bounds = containerView!.bounds
        
    }
}
