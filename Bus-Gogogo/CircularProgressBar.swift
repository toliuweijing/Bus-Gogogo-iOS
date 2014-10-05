@IBDesignable
class CircularProgressBar: UIView {
  
  enum State {
    case Loading, Normal
  }

  var state: State = State.Normal {
    didSet {
      if state == State.Loading {
        setLoading()
      } else {
        setNormal()
      }
    }
  }
  
  weak var delegate: CircularProgressBarDelegate?
  
  var radius: CGFloat {
    return CGRectGetHeight(self.frame) / 2
  }
  
  // sec per circle
  var speed: NSTimeInterval = 1
  
  var color: UIColor = UIColor.blueColor() {
    didSet {
      self.layer.borderColor = color.CGColor
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  private func commonInit() {
    state = State.Normal
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("onTap")))
  }
  
  @objc func onTap() {
    flipState()
    delegate?.onTap(self)
  }
  
  private func flipState() {
    state = state == State.Loading ? State.Normal : State.Loading
  }
  
  override func setNeedsDisplay() {
    super.setNeedsDisplay()
    self.layer.setNeedsDisplay()
    self.layer.sublayers?.first?.needsDisplay()
  }
  
  func setNormal() {
    self.layer.removeAllAnimations()
    self.layer.sublayers?.removeAll(keepCapacity: true)
    
    self.backgroundColor = UIColor.clearColor()
    self.layer.cornerRadius = radius
    self.layer.borderWidth = 1.0
    self.layer.borderColor = color.CGColor
    self.layer.masksToBounds = true
    
    self.setNeedsDisplay()
  }
  
  func setLoading() {
    // clear border
    self.layer.borderWidth = 0
    
    var circlePath = UIBezierPath(
      arcCenter: CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds)),
      radius: self.radius,
      startAngle: 0,
      endAngle: 6,
      clockwise: true)
    
    var circleLayer = CAShapeLayer()
    circleLayer.lineWidth = 2.0
    circleLayer.path = circlePath.CGPath
    circleLayer.fillColor = self.backgroundColor?.CGColor
    circleLayer.strokeColor = self.color.CGColor
    circleLayer.shadowOffset = CGSizeZero
    circleLayer.shadowRadius = 0
    
    self.layer.sublayers?.removeAll(keepCapacity: false)
    self.layer.addSublayer(circleLayer)
    
    var animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.duration = speed
    animation.fromValue = 0
    animation.toValue = M_PI * 2
    animation.cumulative = true
    animation.repeatCount = 1000
    
    self.layer.removeAllAnimations()
    self.layer.addAnimation(animation, forKey: "rotation")
    
    self.setNeedsDisplay()
  }
}

protocol CircularProgressBarDelegate: class {
  func onTap(progressBar: CircularProgressBar)
}
  