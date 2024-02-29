//
//  HomeViewController.swift
//  Animation
//
//  Created by Daniil MacBook Pro on 29.02.2024.
//

import UIKit

final class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    private weak var delegate: HomeViewControllerDelegate?
    private var textAnimationView = UIView()
    private var greedAnimationView = UIView()
    private var loaderAnimationView = UIView()
    
    private var backgroundLayer: CAShapeLayer?
    private var progressLayer: CAShapeLayer?
    
    init(delegate: HomeViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .gray
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"), 
            style: .done,
            target: self,
            action: #selector(didTapMenuButton)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        setupTextAnimationView()
        textAnimationView.isHidden = false
        view.addSubview(textAnimationView)
        
        setupGreedAnimationView()
        greedAnimationView.isHidden = true
        view.addSubview(greedAnimationView)
        
        setupLoaderAnimationView()
        loaderAnimationView.isHidden = true
        view.addSubview(loaderAnimationView)
    }

    @objc private func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    func animations(option: MenuOptions) {
        switch option {
        case .home:
            homeAnimation()
        case .greed:
            greedAnimation()
        case .loader:
            loaderAnimation()
        }
    }
    
    private func homeAnimation() {
        title = MenuOptions.home.rawValue
        
        textAnimationView.isHidden = false
        greedAnimationView.isHidden = true
        loaderAnimationView.isHidden = true
    }
    
    private func greedAnimation() {
        title = MenuOptions.greed.rawValue
        greedAnimationView.isHidden = false
        textAnimationView.isHidden = true
        loaderAnimationView.isHidden = true
    }
    
    private func loaderAnimation() {
        title = MenuOptions.loader.rawValue

        loaderAnimationView.isHidden = false
        textAnimationView.isHidden = true
        greedAnimationView.isHidden = true
        
        resetProgressBar()
        startAnimation(rating: 76, duration: 2.0)
    }
    
    private func setupTextAnimationView() {
        let textAnimationView = UIView()
        textAnimationView.frame = view.frame
        textAnimationView.backgroundColor = .white
        
        self.textAnimationView = textAnimationView
        
        let darkTextLabel = UILabel()
        darkTextLabel.text = "Animation"
        darkTextLabel.textColor = UIColor(white: 1, alpha: 0.2)
        darkTextLabel.font = UIFont.systemFont(ofSize: 80)
        darkTextLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        darkTextLabel.textAlignment = .center
        
        self.textAnimationView.addSubview(darkTextLabel)
        
        let shinyTextLabel = darkTextLabel
        shinyTextLabel.textColor = .black
        
        textAnimationView.addSubview(shinyTextLabel)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = shinyTextLabel.frame
                
        let angle = 45 * CGFloat.pi / 100
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        shinyTextLabel.layer.mask = gradientLayer

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3.0
        animation.fromValue = -textAnimationView.frame.width
        animation.toValue = textAnimationView.frame.width
        animation.repeatCount = .infinity
        
        gradientLayer.add(animation, forKey: "animation")
    }
    
    private func setupGreedAnimationView() {
        let greedAnimationView = UIView()
        greedAnimationView.frame = view.frame
        
        greedAnimationView.backgroundColor = .white
        
        let firstView = UIView()
        firstView.backgroundColor = .red
        firstView.frame = CGRect(
            origin: CGPoint(
                x: (greedAnimationView.frame.maxX / 2)-50.0,
                y: (greedAnimationView.frame.maxY / 2) - 50
            ),
            size: CGSize(width: 50.0, height: 50.0))
        greedAnimationView.addSubview(firstView)
        
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFirstView(_:))))
        
        let secondView = UIView()
        secondView.backgroundColor = .green
        secondView.frame = CGRect(
            origin: CGPoint(
                x: (greedAnimationView.frame.maxX / 2) - 50.0,
                y: (greedAnimationView.frame.maxY / 2)
            ),
            size: CGSize(width: 50.0, height: 50.0))
        greedAnimationView.addSubview(secondView)
        
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSecondView(_:))))
        
        let thirdView = UIView()
        thirdView.backgroundColor = .cyan
        thirdView.frame = CGRect(
            origin: CGPoint(
                x: (greedAnimationView.frame.maxX / 2),
                y: (greedAnimationView.frame.maxY / 2) - 50.0
            ),
            size: CGSize(width: 50.0, height: 50.0))
        greedAnimationView.addSubview(thirdView)
        
        thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapThirdtView(_:))))
        
        let fourthView = UIView()
        fourthView.backgroundColor = .black
        fourthView.frame = CGRect(
            origin: CGPoint(
                x: (greedAnimationView.frame.maxX / 2),
                y: (greedAnimationView.frame.maxY / 2)
            ),
            size: CGSize(width: 50.0, height: 50.0))
        greedAnimationView.addSubview(fourthView)
        
        fourthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFourthView(_:))))
        
        self.greedAnimationView = greedAnimationView
    }
    
    @objc func didTapFirstView(_ sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 2.0, animations: {
            sender.view?.alpha = 0.2
        }, completion: {  _ in
            sender.view?.alpha = 1.0
        })
    }
    
    @objc func didTapSecondView(_ sender: UIPanGestureRecognizer) {
        let point = sender.view?.center
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                sender.view?.center = self.view.center
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5, animations: {
                sender.view?.backgroundColor = .red
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                sender.view?.backgroundColor = .green
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1, animations: {
                sender.view?.center = point!
            })
        })
    }
    
    @objc func didTapThirdtView(_ sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 2.0, animations: {
            sender.view?.transform = CGAffineTransform(rotationAngle: .pi)
        })
    }
    
    @objc func didTapFourthView(_ sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 2.0, animations: {
            sender.view?.alpha = 0.2
            sender.view?.transform = CGAffineTransform(rotationAngle: .pi)
            
            sender.view?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0.0, y: -50.0)
        }, completion: {  _ in
            UIView.animate(withDuration: 2.0, animations: {
                sender.view?.alpha = 1.0
                sender.view?.transform = .identity
            })
        })
    }
    
    private func setupLoaderAnimationView() {
        let loaderAnimationView = UIView()
        loaderAnimationView.frame = view.frame
        
        self.loaderAnimationView = loaderAnimationView
        loaderAnimationView.backgroundColor = .white
        
        let backgroundLayer = configureBackroundLayer()
        loaderAnimationView.layer.addSublayer(backgroundLayer)
        self.backgroundLayer = backgroundLayer
        
        let progressLayer = configureProgressLayer()
        loaderAnimationView.layer.addSublayer(progressLayer)
        self.progressLayer = progressLayer
        
        self.loaderAnimationView = loaderAnimationView
    }
    
    private func configureBackroundLayer() -> CAShapeLayer {
        let backgroundLayer = CAShapeLayer()
        
        backgroundLayer.path = configureProgresBarTab()
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 8.0
        backgroundLayer.lineCap = .round
        backgroundLayer.fillColor = nil
        
        return backgroundLayer
    }
    
    private func resetProgressBar() {
        progressLayer?.strokeEnd = 0.0
    }
    
    private func configureProgressLayer() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        
        progressLayer.path = configureProgresBarTab()
        progressLayer.strokeColor = UIColor.green.cgColor
        progressLayer.lineWidth = 8.0
        progressLayer.lineCap = .round
        progressLayer.fillColor = nil
        progressLayer.strokeEnd = 0.5
        
        self.progressLayer = progressLayer // fix bugs
        startAnimation(rating: 76, duration: 2.0)
        
        return progressLayer
    }

    private func configureProgresBarTab() -> CGPath {
        return UIBezierPath(
            arcCenter: CGPoint(x: self.loaderAnimationView.center.x, y: self.loaderAnimationView.frame.width / 2),
            radius: 100.0,
            startAngle: 3 * CGFloat.pi / 4,
            endAngle: CGFloat.pi / 4,
            clockwise: true
        ) .cgPath
    }
    
    private func startAnimation(rating: Int, duration: TimeInterval) {
        let progress = CGFloat(rating) / 100.0
        
        progressLayer?.strokeEnd = progress
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = progress
        strokeEndAnimation.duration = duration
        
        progressLayer?.add(strokeEndAnimation, forKey: "strokeEndAnimation")
    }
}
