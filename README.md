# Material Button with Swift

AndroidのMaterialデザインで採用されているボタンのアニメーションをiOSで利用出来る様にSwiftで作成しました。

![Material Button Cross](http://fromkk.me/materialbutton/img/material_button_cross.gif "Material Button Cross")

![Material Button Arrow](http://fromkk.me/materialbutton/img/material_button_arrow.gif "Material Button Arrow")

## Ripple button usage

```Swift
self.rippleButton = RippleButton()
self.rippleButton.setTitle("Ripple Button", forState: UIControlState.Normal)
self.rippleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
self.rippleButton.backgroundColor = UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
self.rippleButton.frame = CGRect(x: 30.0, y: 100.0, width: 200.0, height: 40.0)
self.view.addSubview(self.rippleButton)
```

## Animation button usage

```Swift
var materialButton1 =  MaterialButton(type: MaterialButtonType.ArrowLeft)
materialButton1.delegate = self
self.navigationItem.leftBarButtonItem = materialButton1

var materialButton2 =  MaterialButton(type: MaterialButtonType.ArrowRight)
materialButton2.delegate = self
self.navigationItem.rightBarButtonItem = materialButton2
```

| MaterialButtonType |
|--------------------|
| Cross              |
| ArrowLeft          |
| ArrowRight         |
